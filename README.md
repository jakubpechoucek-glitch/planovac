# planovac — rodinný plánovač volna

Společný kalendář rodiny: kdo má kdy volno (Lukáš v ISM, Matěj na UCL, Jana v práci, Jakub od 2027 bez práce), Janina dovolená (25 pracovních dnů ročně) a hlasování o tom, kam a na jak dlouho vyrazit po jihovýchodní Asii.

- **Web:** https://jakubpechoucek-glitch.github.io/planovac/
- **Ukázka bez přihlášení:** https://jakubpechoucek-glitch.github.io/planovac/?demo
- **Rozcestník (rodinný portál):** https://jakubpechoucek-glitch.github.io/rozcestnik/

## Co umí

| Záložka | Obsah |
|---|---|
| **Přehled** | Úplně nahoře (jen když nějaký je) žlutý panel **🗳️ Rozpracované návrhy cest**: u každého neuzavřeného termínu s budoucím datem ukazuje, kdo ještě **nenavrhl destinaci** a kdo **neohodnotil všechny destinace**. Povinní jsou Jana, Jakub a Lukáš, Matěj je uvedený zvlášť jako nepovinný. Když něco dluží přihlášený, je návrh oranžově orámovaný s řádkem „👉 Na tobě: …“; když všichni povinní hlasovali, je zelený s tím, která destinace vede. Tlačítko **Hlasovat / Otevřít** přepne na kartu návrhu. Záložka **Cesty a hlasování** má oranžový odznak s počtem návrhů, které čekají na přihlášeného. Pod tím kompaktní panel **Kdo je kde**: 4 nejbližší cesty jednotlivých členů rodiny (soukromé i služební) a potvrzené rodinné cesty, ostatní pod tlačítkem **Zobrazit všechny**; u cesty s lety je „✈️ počet“. Tlačítko **+ Přidat cestu** otevře dialog, kde se vybere kdo (Jana, Jakub, Lukáš, Matěj; předvyplněný je přihlášený), typ (**Soukromá cesta** nebo **Služební cesta**) a **lety** – řádky datum + text (např. „TG621 MNL → BKK 13:10–15:45“; přílet další den se píše do textu). Pod ním 12 měsíců pod sebou, pro každou osobu řádek s vybarvenými dny volna. Plná barva = zapsané volno (prázdniny, dovolená), světlá = víkend, svátek nebo „bez práce“. Řádek **Spolu** svítí zeleně, když mají volno Jana, Jakub i Lukáš a nikdo z nich není pryč; souvislé společné volno od 3 dní má zelený **rámeček** přes všechny řádky se štítkem délky (čárkovaná strana = pokračuje v sousedním měsíci). Služební cesta je šedě šrafovaná, „volno, ale jinde“ je barva osoby s tečkami; řádek **Cesty** ukazuje potvrzené cesty. Červené datum v hlavičce = svátek na Filipínách. Den s letem má v buňce osoby **✈**. Najetím myší na den se ukáže bublina s důvodem a detaily letů; kliknutím (na mobilu klepnutím) se bublina připne a **číslo letu** (např. TG621, TK 0085) je odkaz na **Flightradar24**, kde je vidět, kde letadlo právě je. Číslo letu se pozná automaticky z textu letu, takže ho stačí do textu napsat. Šipky posouvají o 3 měsíce. |
| **Cesty a hlasování** | Nahoře panel **Volné termíny pro celou rodinu**: nadcházejících až 8 úseků alespoň 3 dny (stejné jako rámečky v Přehledu), kdy mají Jana, Jakub i Lukáš volno bez další dovolené a nikdo není na cestě; **Navrhnout** otevře nový termín s předvyplněnými daty. Pod tím **návrhy cest** – každý návrh je **termín** (odjezd, návrat, poznámka). K termínu navrhne **každý člen až 3 destinace** (státy s vlajkou ze seznamu `ZEME`, detail místa nepovinně a klidně později); první tipy jdou zadat rovnou při zakládání termínu, další tlačítkem **+ Moje destinace (x/3)**. **Všichni hodnotí všechny destinace 1–5 hvězdičkami** (i ty, které navrhl někdo jiný). Destinace jsou seřazené podle průměru, vedoucí je zeleně. **✓ Vybrat** u destinace potvrdí cestu s touto destinací, zapíše ji do kalendáře a Janě vytvoří dovolenou. Termín jde zamítnout a potvrzený / zamítnutý vrátit mezi návrhy (výběr destinace se tím zruší). Svoje destinace může autor upravit (✎) nebo smazat (🗑). |
| **Janina dovolená** | Za vybraný rok: nárok, vyčerpáno (dny před dneškem), naplánováno, zbývá. Seznam dovolených s počtem odečtených pracovních dnů. |
| **Společná volna** (předposlední záložka) | Souvislé úseky alespoň 3 dny (pevně, konstanta `OKNA_MIN`), kdy má volno Lukáš i Jakub. U každého je, kolik pracovních dnů dovolené by musela čerpat Jana a kolik dní z toho má volno Matěj. Tlačítko **Navrhnout cestu** předvyplní termín. |
| **Úpravy** | Zapsané volno po osobách (přidat, upravit, smazat), filipínské svátky (přidat nově vyhlášený, smazat) a nastavení: od kdy má Jakub volno a Janin roční nárok. |

### Pravidla výpočtu

- **Lukáš, Jana, Jakub:** volno je zapsané volno + víkendy + filipínské svátky. Jakub má navíc volno každý den od data v nastavení (`jakub_volno_od`, výchozí 1. 1. 2027).
- **Služební cesta** (`typ = sluzebni`): osoba je pracovně pryč – není to volno ani v den, kdy by jinak bylo (víkend, svátek), a nečerpá se z ní dovolená. Do společného volna se nepočítá; u oken a návrhů cest se ukáže „Jana X dní na služební cestě“.
- **Soukromá cesta** (`typ = cesta`): osoba má volno, ale je jinde (např. Matěj u babičky v Praze přes reading week, Jakub nebo Lukáš na výletě). Do společného volna se nepočítá a u oken se ukáže „Matěj X dní jinde“. **Janina** soukromá cesta čerpá v pracovní dny dovolenou stejně jako běžná dovolená a je vidět i v záložce Janina dovolená.
- **Škola / práce i přes svátek** (`typ = vyuka`): zruší volno v dny, kdy by jinak bylo (svátek, víkend, prázdniny). Příklad: ASEAN svátky 16.–18. 11. 2026 platí pro celou rodinu, ale ISM učí 2. a 3. den, takže Lukáš má na 17.–18. 11. záznam „vyuka“. V Přehledu je taková buňka bílá s obrysem v barvě osoby. U Jany z takového dne udělá pracovní den (případná dovolená ho čerpá).
- **Rámeček v Přehledu** = souvislý úsek alespoň 3 dnů, kdy Jana, Jakub i Lukáš mají volno a nejsou pryč (počítají se i víkendy a svátky).
- **Matěj:** je v Londýně, takže víkendy ani filipínské svátky se mu nepočítají – volno má jen v zapsaných obdobích mimo výuku na UCL.
- **Janina dovolená** se počítá v **pracovních dnech**: všední den, který není svátkem na Filipínách. Překrývající se záznamy se nepočítají dvakrát. Počítá se po kalendářních letech.
- **Potvrzená cesta** vytvoří Janě záznam dovolené s vazbou `cesta_id`. Úprava termínu cesty ho posune, vrácení mezi návrhy, zamítnutí nebo smazání cesty ho odstraní. Takový záznam se needituje ručně (v seznamech je označený „z cesty“).
- Hodnotí se každá destinace zvlášť; průměr počítá jen ty, kdo hodnotili, a ukazuje i počet hlasů („2 z 4“). Jedna osoba má u destinace jeden hlas (dalším kliknutím ho změní).

## Jak to funguje

- Celá aplikace je v jediném souboru `index.html` (HTML + CSS + JS), bez buildu a bez závislostí kromě Supabase klienta z Rozcestníku.
- Hostuje se na **GitHub Pages**: push do `main` se rovnou nasadí.
- V hlavičce je tlačítko **← Rozcestník** pro návrat na rodinný portál. Poslední otevřená záložka se pamatuje v prohlížeči (`localStorage`, klíč `planovac-view`).

### Přihlášení

- Stránka je za společným přihlášením rodiny z repa [`rozcestnik`](https://github.com/jakubpechoucek-glitch/rozcestnik) (Supabase).
- Skripty se načítají absolutní cestou ze stejné domény: `/rozcestnik/vendor/supabase-js-2.45.4.js` a `/rozcestnik/auth.js`. Přihlášení proto funguje jen na `jakubpechoucek-glitch.github.io`.
- `RodinaAuth.vyzadujPrihlaseni()` pošle nepřihlášeného na Rozcestník. Dokud ověření neproběhne, je stránka skrytá (třída `auth-ceka`).
- Kdo je přihlášený, se pozná z `moje_jmeno()` (tabulka `clenove`): podle křestního jména se přiřadí k osobě (Jana, Jakub, Lukáš, Matěj). Tak se ví, čí hvězdičky se mají měnit.

### Data (Supabase)

Data jsou v Supabase projektu Rozcestníku (`unoefgbzymlwwehgzusf`). Definice je v [`sql/01_tabulky.sql`](sql/01_tabulky.sql), počáteční data v [`sql/02_data_ism_ucl_svatky.sql`](sql/02_data_ism_ucl_svatky.sql). V Supabase jsou aplikované jako migrace `planovac_tabulky`, `planovac_volno_cesta`, `planovac_sluzebni_cesta`, `planovac_vyuka_pres_svatek` a `planovac_varianty_destinaci`.

| Tabulka | Obsah |
|---|---|
| `plan_volno` | jeden řádek = volno jedné osoby od–do: `osoba` (`lukas`/`matej`/`jana`/`jakub`), `zacatek`, `konec`, `typ` (`skola` prázdniny, `dovolena` Janina dovolená, `sluzebni` služební cesta, `cesta` soukromá cesta, `vyuka` škola/práce i přes svátek, `jine` jiné volno), `popis`, `zdroj` (ISM, UCL, ručně, cesta), `cesta_id` (jen u dovolené z potvrzené cesty), `lety` (jsonb pole `{datum, text}` – lety u cesty, v kalendáři ✈ s bublinou), plus `pridal`/`vytvoreno`, `upravil`/`upraveno` |
| `plan_svatky` | `datum` (unikátní), `nazev`, `zdroj` – státní svátky na Filipínách |
| `plan_nastaveni` | klíč–hodnota (jsonb): `jana_narok` (25), `jakub_volno_od` (`"2027-01-01"`) |
| `plan_cesty` | návrh cesty = **termín**: `zacatek`, `konec`, `poznamka`, `stav` (`navrh`/`potvrzena`/`zamitnuta`), `destinace` = vybraná destinace (vyplní se při potvrzení, u návrhu prázdná), plus kdo a kdy |
| `plan_destinace` | varianta destinace k termínu: `cesta_id`, `zeme` (např. „🇯🇵 Japonsko“), `detail`, `navrhl` (nastaví server); nejvýš 3 na člena a termín |
| `plan_hlasy` | `destinace_id` + `kdo` (primární klíč), `hodnoceni` 1–5 |

- **Přístup:** RLS politika `je_clen()` jako u ostatních tabulek Rozcestníku. Anonymní klíč nedostane nic.
- **Kdo a kdy:** sloupce `pridal`, `vytvoreno`, `upravil`, `upraveno` plní trigger `plan_audit()` na serveru podle přihlášeného člena.
- **Hlasy:** trigger `plan_hlasy_kdo()` vždy nastaví `kdo` na přihlášeného člena, takže hlasovat za někoho jiného nejde. Číst smí hlasy celá rodina, měnit a mazat jen svůj.
- **Destinace:** trigger `plan_destinace_navrhl()` nastaví `navrhl` na přihlášeného člena a odmítne čtvrtou destinaci téhož člena k témuž termínu. Číst a přidávat smí celá rodina, upravit a smazat jen autor.
- **Smazání cesty** smaže kaskádou i její destinace, hlasy a Janinu dovolenou z ní; smazání destinace smaže její hlasy.

### Odkud jsou data (import 7. 11. 2026)

- **ISM (Lukáš):** z PDF kalendářů *ISM_CalendarSY26-27_Sep32026.pdf* a *Calendar-SY27-28_October52026_BOTapproved-07Oct2026.pdf*. Zapsané jsou dny bez výuky, které nejsou státním svátkem (faculty in-service, podzimní/semestrální/jarní prázdniny, léto). Státní svátky z kalendáře jsou v `plan_svatky`.
  - Letní prázdniny 2028 končí odhadem 31. 7. 2028 – po vydání kalendáře 2028/29 opravit.
- **UCL (Matěj):** oficiální [term dates](https://www.ucl.ac.uk/study/current-students/life-ucl/term-dates-and-closures). Zapsané jsou reading weeks a prázdniny mezi trimestry. Konec Velikonoc 2028 je odhad (summer term 2028 zatím nebyl zveřejněný); reading weeks 2027/28 doplnit, až je UCL zveřejní.
- **Svátky na Filipínách:** [Nager.Date](https://date.nager.at) pro 2026–2028, doplněné o svátky uvedené v kalendářích ISM (volby, EDSA, Eid il Fitr, Eid il Adha, All Souls' Day). Muslimské svátky a „special non-working days“ vyhlašuje vláda průběžně – přidávají se v záložce **Úpravy**. Když škola (nebo práce) svátek nedodrží, přidej dotyčnému záznam typu **Škola / práce i přes svátek** – svátek se tím pro ostatní nezmění.
- **ASEAN Summit 2026:** 16.–18. 11. 2026 special non-working days v Metro Manila ([Proclamation No. 1447](https://philstarlife.com/news-and-views/968280-palace-announces-nov-16-to-18-as-special-non-working-days-asean-summit)); ISM učí 17. a 18. 11.

### Nový školní rok / nový kalendář

1. V záložce **Úpravy** vyber Lukáše (nebo Matěje) a přidej prázdniny a volné dny z nového kalendáře (typ „Školní prázdniny“). Dny, které jsou státním svátkem, stačí mít ve svátcích.
2. Doplň svátky na další rok (Nager.Date nebo oficiální proklamace).
3. Případně oprav odhadnuté konce (léto 2028 v ISM, Velikonoce 2028 na UCL).

Hromadný import jde i přes SQL podle vzoru v `sql/02_data_ism_ucl_svatky.sql`.

### Ukázkový režim `?demo`

- Smyšlená data přímo v kódu (`demoData()`), posunutá k aktuálnímu roku, s generickými prázdninami. Nevyžaduje přihlášení, přihlášený je „Jakub“.
- Přidávat, hlasovat, potvrzovat i mazat jde, ale nic se neukládá. Po obnovení stránky jsou data zpět.

## Lokální vývoj

Stránka potřebuje skripty z `/rozcestnik/`, takže ji servíruj ze složky, kde leží `Planovac` i `rozcestnik` vedle sebe:

```bash
cd ~ && python3 -m http.server 8767 --bind 127.0.0.1
```

Pak otevři `http://localhost:8767/Planovac/?demo`. Bez `?demo` stránka lokálně přesměruje na přihlášení Rozcestníku.

## Nápady na další rozvoj

- Export do Google Kalendáře / ICS odkaz pro telefon
- Upozornění, když se blíží konec hlasování nebo Janě dochází dovolená
- U destinací počasí v daném měsíci (monzuny) a odhad ceny letenek
- Převod nevyčerpané dovolené do dalšího roku
