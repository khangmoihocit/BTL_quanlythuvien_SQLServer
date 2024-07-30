create function test
( @a int )
returns int
as
begin
	return @a + 1;
end


select dbo.test(13) gia