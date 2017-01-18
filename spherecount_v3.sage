#ONLY WORKS FOR STD OR HEX UNTIL FURTHER KNOWLEDGE
attach('spherecount_malcifier.sage')

#(group element list, group element list) -> group element list
def increment_by_letter(generating_set,strings):
	new_strings = []
	for string in strings: 
		for generator in generating_set:
			new_strings.append(string*generator)
			new_strings.append(string*generator^-1)
	return new_strings

#group element list -> (int,int,int) Set
def get_Malcev_coords(strings):
	Malcev_coords = set([])
	for string in strings:
		Malcev_coord = fast_Malcev_coord(string)
		Malcev_coords.add(Malcev_coord)
	return Malcev_coords

#(int,int,int) Set -> group element list
def generate_strings_from_coords(coords):
	strings = []
	for coord in coords:
		x,y,z = coord[0],coord[1],coord[2]
		strings.append(a^x*b^y*c^z)
	return strings

def sphere_generator(generating_set,current_radius,previous_shell,current_shell):
	while True:
		yield current_radius, previous_shell, current_shell

		new_shell = set([])
		old_strings = generate_strings_from_coords(current_shell)
		new_strings = increment_by_letter(generating_set,old_strings)
		new_words = get_Malcev_coords(new_strings)
		for word in new_words: 
			if word not in current_shell and word not in previous_shell:
				new_shell.add(word)

		previous_shell = set(current_shell)
		current_shell = set(new_shell)
		current_radius = current_radius + 1
