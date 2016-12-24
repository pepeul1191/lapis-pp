 return {
	GET = function(self)
		if tonumber(self.params.edad) > 18 then
			return "Mayor de edad " --.. self.user.name
		else
			return "Menor de edad"
		end
	end
 }