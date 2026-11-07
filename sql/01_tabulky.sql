-- Plánovač: tabulky a pravidla přístupu
-- V Supabase (projekt Rozcestníku unoefgbzymlwwehgzusf) aplikováno 7. 11. 2026
-- jako migrace planovac_tabulky, planovac_volno_cesta planovac_sluzebni_cesta, planovac_vyuka_pres_svatek a planovac_varianty_destinaci (7. 11. 2026).
-- Pozn.: původní plan_hlasy (hlas k celé cestě, s komentářem) nahradila migrace planovac_varianty_destinaci – viz konec souboru.
-- Funkce je_clen() a moje_jmeno() a tabulka clenove pochází z Rozcestníku.

-- ── Tabulky ──
create table public.plan_volno (
  id bigint generated always as identity primary key,
  osoba text not null check (osoba in ('lukas','matej','jana','jakub')),
  zacatek date not null,
  konec date not null,
  typ text not null default 'jine' check (typ in ('skola','dovolena','cesta','jine')),
  popis text not null default '',
  zdroj text not null default 'ručně',
  pridal text, vytvoreno timestamptz default now(),
  upravil text, upraveno timestamptz,
  check (konec >= zacatek)
);

create table public.plan_svatky (
  id bigint generated always as identity primary key,
  datum date not null unique,
  nazev text not null,
  zdroj text not null default 'ručně',
  pridal text, vytvoreno timestamptz default now(),
  upravil text, upraveno timestamptz
);

create table public.plan_nastaveni (
  klic text primary key,
  hodnota jsonb not null,
  upraveno timestamptz default now()
);

create table public.plan_cesty (
  id bigint generated always as identity primary key,
  destinace text not null,
  zacatek date not null,
  konec date not null,
  poznamka text not null default '',
  stav text not null default 'navrh' check (stav in ('navrh','potvrzena','zamitnuta')),
  pridal text, vytvoreno timestamptz default now(),
  upravil text, upraveno timestamptz,
  check (konec >= zacatek)
);

create table public.plan_hlasy (
  cesta_id bigint not null references public.plan_cesty(id) on delete cascade,
  kdo text not null,
  hodnoceni int not null check (hodnoceni between 1 and 5),
  komentar text not null default '',
  upraveno timestamptz default now(),
  primary key (cesta_id, kdo)
);

-- migrace planovac_volno_cesta: potvrzená cesta zapíše Janě dovolenou;
-- vazba, aby šla zrušit spolu s cestou
alter table public.plan_volno add column cesta_id bigint references public.plan_cesty(id) on delete cascade;
create index plan_volno_cesta_id on public.plan_volno(cesta_id);

-- migrace planovac_sluzebni_cesta: služební cesta (pracovně pryč, není volno)
-- a cesta jinam (volno, ale pryč – např. Matěj do Čech)
alter table public.plan_volno drop constraint plan_volno_typ_check;
alter table public.plan_volno add constraint plan_volno_typ_check
  check (typ in ('skola','dovolena','cesta','sluzebni','jine'));

-- migrace planovac_vyuka_pres_svatek: škola / práce i přes svátek nebo víkend
-- (např. ISM učí 2. a 3. den ASEAN svátků)
alter table public.plan_volno drop constraint plan_volno_typ_check;
alter table public.plan_volno add constraint plan_volno_typ_check
  check (typ in ('skola','dovolena','cesta','sluzebni','vyuka','jine'));

-- ── Kdo a kdy přidal/upravil – plní server podle přihlášeného člena ──
create or replace function public.plan_audit() returns trigger
language plpgsql security definer set search_path to 'public' as $$
begin
  if tg_op = 'INSERT' then
    new.pridal    := coalesce(public.moje_jmeno(), new.pridal);
    new.vytvoreno := now();
    new.upravil   := null;
    new.upraveno  := null;
  else
    new.pridal    := old.pridal;
    new.vytvoreno := old.vytvoreno;
    new.upravil   := coalesce(public.moje_jmeno(), new.upravil);
    new.upraveno  := now();
  end if;
  return new;
end $$;

create trigger plan_volno_audit  before insert or update on public.plan_volno  for each row execute function public.plan_audit();
create trigger plan_svatky_audit before insert or update on public.plan_svatky for each row execute function public.plan_audit();
create trigger plan_cesty_audit  before insert or update on public.plan_cesty  for each row execute function public.plan_audit();

-- ── Hlas vždy patří přihlášenému – podvrhnout cizí hlas nejde ──
create or replace function public.plan_hlasy_kdo() returns trigger
language plpgsql security definer set search_path to 'public' as $$
begin
  if public.moje_jmeno() is not null then
    new.kdo := public.moje_jmeno();
  end if;
  if tg_op = 'UPDATE' and new.kdo is distinct from old.kdo then
    raise exception 'Cizí hlas měnit nelze';
  end if;
  new.upraveno := now();
  return new;
end $$;
create trigger plan_hlasy_kdo before insert or update on public.plan_hlasy for each row execute function public.plan_hlasy_kdo();

-- ── Row Level Security: jen členové rodiny ──
alter table public.plan_volno     enable row level security;
alter table public.plan_svatky    enable row level security;
alter table public.plan_nastaveni enable row level security;
alter table public.plan_cesty     enable row level security;
alter table public.plan_hlasy     enable row level security;

create policy "jen rodina" on public.plan_volno     for all to authenticated using (je_clen()) with check (je_clen());
create policy "jen rodina" on public.plan_svatky    for all to authenticated using (je_clen()) with check (je_clen());
create policy "jen rodina" on public.plan_nastaveni for all to authenticated using (je_clen()) with check (je_clen());
create policy "jen rodina" on public.plan_cesty     for all to authenticated using (je_clen()) with check (je_clen());
-- hlasy: číst smí celá rodina, měnit a mazat jen svůj
create policy "rodina cte"        on public.plan_hlasy for select to authenticated using (je_clen());
create policy "svuj hlas"         on public.plan_hlasy for insert to authenticated with check (je_clen());
create policy "svuj hlas uprava"  on public.plan_hlasy for update to authenticated using (je_clen() and kdo = moje_jmeno()) with check (je_clen());
create policy "svuj hlas smazani" on public.plan_hlasy for delete to authenticated using (je_clen() and kdo = moje_jmeno());

-- ── Výchozí nastavení ──
insert into public.plan_nastaveni (klic, hodnota) values
  ('jana_narok', '25'::jsonb),
  ('jakub_volno_od', '"2027-01-01"'::jsonb);

-- ── Migrace planovac_varianty_destinaci ──
-- Cesta = termín; ke každému termínu navrhne každý člen až 3 destinace (státy)
-- a všichni hodnotí každou destinaci 1–5 hvězdičkami.

-- plan_cesty.destinace = vybraná destinace (vyplní se při potvrzení), u návrhu může chybět
alter table public.plan_cesty alter column destinace drop not null;

create table public.plan_destinace (
  id bigint generated always as identity primary key,
  cesta_id bigint not null references public.plan_cesty(id) on delete cascade,
  zeme text not null,
  detail text not null default '',
  navrhl text,
  vytvoreno timestamptz default now()
);
create index plan_destinace_cesta_id on public.plan_destinace(cesta_id);

-- navrhl = přihlášený člen (nastaví server), nejvýš 3 destinace na člena a termín
create or replace function public.plan_destinace_navrhl() returns trigger
language plpgsql security definer set search_path to 'public' as $$
begin
  if tg_op = 'INSERT' then
    new.navrhl := coalesce(public.moje_jmeno(), new.navrhl);
    new.vytvoreno := now();
    if (select count(*) from public.plan_destinace
        where cesta_id = new.cesta_id and navrhl = new.navrhl) >= 3 then
      raise exception 'Každý může k termínu navrhnout nejvýš 3 destinace';
    end if;
  else
    new.navrhl := old.navrhl;
    new.cesta_id := old.cesta_id;
    new.vytvoreno := old.vytvoreno;
  end if;
  return new;
end $$;
create trigger plan_destinace_navrhl before insert or update on public.plan_destinace
  for each row execute function public.plan_destinace_navrhl();

alter table public.plan_destinace enable row level security;
create policy "rodina cte"      on public.plan_destinace for select to authenticated using (je_clen());
create policy "rodina navrhuje" on public.plan_destinace for insert to authenticated with check (je_clen());
create policy "svoje upravy"    on public.plan_destinace for update to authenticated using (je_clen() and navrhl = moje_jmeno()) with check (je_clen());
create policy "svoje smazani"   on public.plan_destinace for delete to authenticated using (je_clen() and navrhl = moje_jmeno());

-- hlasy nově k destinaci (dosud žádné hlasy nebyly, tabulka se přestavěla)
drop table public.plan_hlasy;
create table public.plan_hlasy (
  destinace_id bigint not null references public.plan_destinace(id) on delete cascade,
  kdo text not null,
  hodnoceni int not null check (hodnoceni between 1 and 5),
  upraveno timestamptz default now(),
  primary key (destinace_id, kdo)
);
create trigger plan_hlasy_kdo before insert or update on public.plan_hlasy
  for each row execute function public.plan_hlasy_kdo();
alter table public.plan_hlasy enable row level security;
create policy "rodina cte"        on public.plan_hlasy for select to authenticated using (je_clen());
create policy "svuj hlas"         on public.plan_hlasy for insert to authenticated with check (je_clen());
create policy "svuj hlas uprava"  on public.plan_hlasy for update to authenticated using (je_clen() and kdo = moje_jmeno()) with check (je_clen());
create policy "svuj hlas smazani" on public.plan_hlasy for delete to authenticated using (je_clen() and kdo = moje_jmeno());
-- (převod 2 existujících cest: Ischgl → varianta 🇦🇹 Rakousko / Ischgl; otázka u únorového termínu → poznámka)
