select r.bibNumber, e.sportIdentCCardNumber, p.firstName, p.familyName, o.shortName, cl.shortName, co.name
from persons as p, entries as e, organisations as o, results as r, eventclasses as cl,
courses as co
where e.competitorId=p.personId and p.defaultOrganisationId=o.organisationId and r.entryId=e.entryId
and r.raceClassId=cl.eventClassId and r.individualCourseId=co.courseId
order by abs(r.bibNumber)