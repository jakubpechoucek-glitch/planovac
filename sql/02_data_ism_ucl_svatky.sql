-- Počáteční data Plánovače (naimportováno 7. 11. 2026)
-- Zdroje:
--   ISM: ISM_CalendarSY26-27_Sep32026.pdf, Calendar-SY27-28_October52026_BOTapproved-07Oct2026.pdf
--   UCL: https://www.ucl.ac.uk/study/current-students/life-ucl/term-dates-and-closures
--   Svátky PH: https://date.nager.at (2026–2028) + svátky uvedené v kalendářích ISM

-- ── Lukáš (ISM): dny bez výuky mimo státní svátky ──
insert into public.plan_volno (osoba, zacatek, konec, typ, popis, zdroj) values
  ('lukas', '2026-09-18', '2026-09-18', 'skola', 'Faculty in-service – bez výuky', 'ISM'),
  ('lukas', '2026-10-26', '2026-10-30', 'skola', 'Podzimní prázdniny', 'ISM'),
  ('lukas', '2026-12-14', '2027-01-01', 'skola', 'Semestrální prázdniny', 'ISM'),
  ('lukas', '2027-02-26', '2027-02-26', 'skola', 'Faculty in-service – bez výuky', 'ISM'),
  ('lukas', '2027-03-22', '2027-03-26', 'skola', 'Jarní prázdniny', 'ISM'),
  ('lukas', '2027-06-05', '2027-08-04', 'skola', 'Letní prázdniny', 'ISM'),
  ('lukas', '2027-09-17', '2027-09-17', 'skola', 'Faculty in-service – bez výuky', 'ISM'),
  ('lukas', '2027-10-25', '2027-10-29', 'skola', 'Podzimní prázdniny', 'ISM'),
  ('lukas', '2027-12-20', '2028-01-07', 'skola', 'Semestrální prázdniny', 'ISM'),
  ('lukas', '2028-02-18', '2028-02-18', 'skola', 'Faculty in-service – bez výuky', 'ISM'),
  ('lukas', '2028-02-21', '2028-02-25', 'skola', 'Únorové prázdniny', 'ISM'),
  ('lukas', '2028-04-10', '2028-04-14', 'skola', 'Velikonoční prázdniny', 'ISM'),
  ('lukas', '2028-06-09', '2028-07-31', 'skola', 'Letní prázdniny (konec odhadem – ověřit v kalendáři 2028/29)', 'ISM');

-- ── Matěj (UCL): období mimo výuku ──
insert into public.plan_volno (osoba, zacatek, konec, typ, popis, zdroj) values
  ('matej', '2026-11-09', '2026-11-13', 'skola', 'Reading week', 'UCL'),
  ('matej', '2026-12-19', '2027-01-10', 'skola', 'Vánoční prázdniny', 'UCL'),
  ('matej', '2027-02-15', '2027-02-19', 'skola', 'Reading week', 'UCL'),
  ('matej', '2027-03-25', '2027-04-25', 'skola', 'Velikonoční prázdniny', 'UCL'),
  ('matej', '2027-06-12', '2027-09-26', 'skola', 'Letní prázdniny', 'UCL'),
  ('matej', '2027-12-18', '2028-01-09', 'skola', 'Vánoční prázdniny', 'UCL'),
  ('matej', '2028-03-25', '2028-04-23', 'skola', 'Velikonoční prázdniny (konec odhadem – ověřit)', 'UCL');

-- ── Státní svátky na Filipínách (od 7/2026) ──
insert into public.plan_svatky (datum, nazev, zdroj) values
  ('2026-08-21', 'Ninoy Aquino Day', 'Nager.Date'),
  ('2026-08-31', 'National Heroes Day', 'Nager.Date'),
  ('2026-10-31', 'All Saints'' Day Eve', 'Nager.Date'),
  ('2026-11-01', 'All Saints'' Day', 'Nager.Date'),
  ('2026-11-02', 'National Election', 'ISM'),
  ('2026-11-30', 'Bonifacio Day', 'Nager.Date'),
  ('2026-12-08', 'Feast of the Immaculate Conception', 'Nager.Date'),
  ('2026-12-24', 'Christmas Eve', 'Nager.Date'),
  ('2026-12-25', 'Christmas Day', 'Nager.Date'),
  ('2026-12-30', 'Rizal Day', 'Nager.Date'),
  ('2026-12-31', 'Last Day of the Year', 'Nager.Date'),
  ('2027-01-01', 'New Year''s Day', 'Nager.Date'),
  ('2027-02-06', 'Lunar New Year', 'Nager.Date'),
  ('2027-02-25', 'EDSA Revolution Day', 'ISM'),
  ('2027-03-10', 'Eid il Fitr', 'ISM'),
  ('2027-03-25', 'Maundy Thursday', 'Nager.Date'),
  ('2027-03-26', 'Good Friday', 'Nager.Date'),
  ('2027-03-27', 'Black Saturday', 'Nager.Date'),
  ('2027-04-09', 'Day of Valor (Bataan Day)', 'Nager.Date'),
  ('2027-05-01', 'Labor Day', 'Nager.Date'),
  ('2027-05-17', 'Eid il Adha', 'ISM'),
  ('2027-06-12', 'Independence Day', 'Nager.Date'),
  ('2027-08-21', 'Ninoy Aquino Day', 'Nager.Date'),
  ('2027-08-30', 'National Heroes Day', 'Nager.Date'),
  ('2027-10-31', 'All Saints'' Day Eve', 'Nager.Date'),
  ('2027-11-01', 'All Saints'' Day', 'Nager.Date'),
  ('2027-11-02', 'All Souls'' Day', 'ISM'),
  ('2027-11-30', 'Bonifacio Day', 'Nager.Date'),
  ('2027-12-08', 'Feast of the Immaculate Conception', 'Nager.Date'),
  ('2027-12-24', 'Christmas Eve', 'Nager.Date'),
  ('2027-12-25', 'Christmas Day', 'Nager.Date'),
  ('2027-12-30', 'Rizal Day', 'Nager.Date'),
  ('2027-12-31', 'Last Day of the Year', 'Nager.Date'),
  ('2028-01-01', 'New Year''s Day', 'Nager.Date'),
  ('2028-01-26', 'Lunar New Year', 'Nager.Date'),
  ('2028-02-25', 'EDSA Revolution Day', 'ISM'),
  ('2028-02-26', 'Eid il Fitr', 'ISM'),
  ('2028-04-09', 'Day of Valor (Bataan Day)', 'Nager.Date'),
  ('2028-04-13', 'Maundy Thursday', 'Nager.Date'),
  ('2028-04-14', 'Good Friday', 'Nager.Date'),
  ('2028-04-15', 'Black Saturday', 'Nager.Date'),
  ('2028-05-01', 'Labor Day', 'Nager.Date'),
  ('2028-05-05', 'Eid il Adha', 'ISM'),
  ('2028-05-08', 'National Election', 'ISM'),
  ('2028-06-12', 'Independence Day', 'Nager.Date'),
  ('2028-08-21', 'Ninoy Aquino Day', 'Nager.Date'),
  ('2028-08-28', 'National Heroes Day', 'Nager.Date'),
  ('2028-10-31', 'All Saints'' Day Eve', 'Nager.Date'),
  ('2028-11-01', 'All Saints'' Day', 'Nager.Date'),
  ('2028-11-30', 'Bonifacio Day', 'Nager.Date'),
  ('2028-12-08', 'Feast of the Immaculate Conception', 'Nager.Date'),
  ('2028-12-24', 'Christmas Eve', 'Nager.Date'),
  ('2028-12-25', 'Christmas Day', 'Nager.Date'),
  ('2028-12-30', 'Rizal Day', 'Nager.Date'),
  ('2028-12-31', 'Last Day of the Year', 'Nager.Date');
