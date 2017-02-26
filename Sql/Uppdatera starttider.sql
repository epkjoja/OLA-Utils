# En SQL som g�r det m�jligt att s�tta starttiderna utanf�r OLA, t.ex. n�r startordningen m�ste sk�tas i Excel (bl.a WRE).
# SQL:en refererar till l�paren visa dess svenska Eventor-id och s�tter starttiden i tv� kolumner i tabellen 'results'.

update results, entries, personids
set results.allocatedStartTime='2017-04-08 10:10:00',
results.startTime='2017-04-08 10:10:00'
where results.entryId=entries.entryId
and entries.competitorId=personids.personId
and personids.externalId='21287';
