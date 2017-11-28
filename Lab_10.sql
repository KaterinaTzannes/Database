create or replace function coursesCredits(int, REFCURSOR) returns refcursor as 
$$
declare
   numberOfCredits int       := $1;
   resultset   REFCURSOR := $2;
begin
   open resultset for 
      select num, name, credits
      from   courses
       where  credits >= numberOfCredits;
   return resultset;
end;
$$ 
language plpgsql;

select coursesCredits(0, 'results');
Fetch all from results;

create or replace function PreReqsFor(courseNum) returns refcursor as 
$$
declare
   numberOfCredits int       := $1;
   resultset   REFCURSOR := $2;
begin
   open resultset for 
	Select *
	from courses
	where num >= credits
	return resultset;
end;
$$ 
language plpgsql;
	
create or replace function IsPreReqFor(courseNum) returns refcursor as 
$$
declare
   numberOfCredits int       := $1;
   resultset   REFCURSOR := $2;
begin
   open resultset for 
	select *
	from courses
	where num <= credits
	return resultset;
end;
$$ 
language plpgsql;