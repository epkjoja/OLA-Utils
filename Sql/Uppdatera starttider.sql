# En SQL som gör det möjligt att sätta starttiderna utanför OLA, t.ex. när startordningen måste skötas i Excel (bl.a WRE).
# SQL:en refererar till löparen via dess svenska Eventor-id och sätter starttiden i två kolumner i tabellen 'results'.
# OBS: Denna SQL kräver att det bara finns EN tävling i OLA-databasen.

update results, entries, personids
set results.allocatedStartTime='2017-04-08 10:10:00',
results.startTime='2017-04-08 10:10:00'
where results.entryId=entries.entryId
and entries.competitorId=personids.personId
and personids.externalId='21287';


# Ett eventuellt bättre alternativ är att istället för att direkt sätt starttiderna för löparna så sätter man unika
# seedningsgrupper på alla löparna i den ordning man vill att dom ska starta. Lägsta numret startar först o högsta numret
# startar sist. När seedningsgrupperna är satta så är det bara att lotta som vanligt ('Starttidsfördelning' måste också vara
# satt till 'Seeded lottning')

update entries, personids
set entries.seedingGroup=10
where entries.competitorId=personids.personId
and personids.externalId=6271;
