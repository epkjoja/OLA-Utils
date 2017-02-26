# En SQL som gör det möjligt att sätta starttiderna utanför OLA, t.ex. när startordningen måste skötas i Excel (bl.a WRE).
# SQL:en refererar till löparen visa dess svenska Eventor-id och sätter starttiden i två kolumner i tabellen 'results'.

update results, entries, personids
set results.allocatedStartTime='2017-04-08 10:10:00',
results.startTime='2017-04-08 10:10:00'
where results.entryId=entries.entryId
and entries.competitorId=personids.personId
and personids.externalId='21287';
