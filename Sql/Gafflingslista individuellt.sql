-- En SQL som gör det möjligt att få ut en gafflingslista på individuella banor för alla löpare.
-- OBS: Denna SQL kräver att det bara finns en tävling i OLA-databasen men kan hantera flera etapper (eventRaceId).
-- Sista kolumnen (resultId) är bra att ha för att senare kunna markera en löpare som ej start. Samma nummer som 
-- återfinns på t.ex minutstartlistan

select r.bibNumber, e.sportIdentCCardNumber, p.firstName, p.familyName, o.shortName, ec.shortName, co.name, r.resultId
from persons as p, entries as e, organisations as o, results as r, eventclasses as ec,
courses as co, raceclasses as rc
where e.competitorId=p.personId and p.defaultOrganisationId=o.organisationId and r.entryId=e.entryId
and r.raceClassId=rc.raceClassId and rc.eventClassId=ec.eventClassId and r.individualCourseId=co.courseId
and rc.eventRaceId=1 and r.runnerStatus!="notParticipating"
order by r.individualCourseId

-- order by abs(r.bibNumber)