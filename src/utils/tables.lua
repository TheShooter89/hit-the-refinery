function merge_tables(t1, t2)
	if not t2 then
		return t1
	end

	for index, value in pairs(t2) do
		t1[index] = value
	end

	return t1
end
