#Written by Hang Lu Su, under the guidance of Moon Duchin and Andrew P. Sánchez.
#Special thanks to Charles Freeman for key insight! 
#-----

#Compute Malcev normal form in O(n) time using key formula:
#b^{y_1}a^{x_1}...b^{y_n}a^{x_n} 
#= a^{x_1+...+x_n} b^{y_1+...+y_n} c^{-[x_1(y_1+...+y_n) + x_2(y_2+...+y_n) + x_n y_n]}.

#For more information, refer to FastMalcifierAlgorithm.pdf
#-----

#Make N_2,2 with generators a,b, c = [a,b]
F.<a,b,c> = FreeGroup()
A, B, C = [x.inverse() for x in F.gens()]

#(word,int) list -> (word,int) list, int
def collect_c(syl):
 	ab_syl = []
 	c_counter = 0
	for i in range(len(syl)):
		if str(syl[i][0]) == 'c':
			power_of_c = syl[i][1]
			c_counter = c_counter + power_of_c
		else: 
			ab_syl.append((syl[i]))

	return ab_syl,c_counter

#list -> word
def reconstruct_word_from_syllables(syl):
	h = F.one()
	for i in range(len(syl)):
		h = h*syl[i][0]^syl[i][1]
	return h

#list -> word
def freely_reduce(syl):
	reduced_word = reconstruct_word_from_syllables(syl)
	syl = list(reduced_word.syllables())
	return syl

#(word,int) list -> (word,int) list
def convert_to_alternating_ba_pattern(syl):
	if syl == []:
		syl = [(b,0),(a,0)]
	else:
		if str(syl[0][0]) != 'b':
			syl.insert(0,(b,0))
		if str(syl[-1][0]) != 'a':
			syl.append((a,0))

#(word,int) list -> int list, int list
def parse_ab_powers(syl):
	a_powers = []
	b_powers = []
	for i in range(len(syl)/2):
		b_powers.append(syl[2*i][1])
		a_powers.append(syl[2*i+1][1])
	return a_powers, b_powers

#(int list, int list) -> int
def compute_Malcev_coords(a_powers,b_powers,c_counter):
	#Given a_powers = [x_1,..,x_n], b_powers = [y_1,...,y_n], 
	#formula for a coordinate is x = (x_1+...+x_n),
	#formula for b coordinate is y = (y_1+...+y_n),
	#formula for c coordinate is z =  -(x_1*(y_1+..+y_n) + x_2*(y_2+...+y_n) + ... + x_n y_n).

	X = sum(a_powers)
	Y = sum(b_powers)

	n = len(a_powers)
	y_partial_sum = 0
	y_partial_sum_list = []
	z_0 = c_counter
	z = 0
	
	for i in range(n):
		y_partial_sum += b_powers[i]
		y_partial_sum_list.append(y_partial_sum)

	for i in range(n):
		z += a_powers[i]*y_partial_sum_list[i]

	Z = -z + z_0

	return X,Y,Z

#word -> (int,int,int)
def fast_Malcev_coord(g):
	syl = list(g.syllables())
	syl,c_counter = collect_c(syl)
	syl = freely_reduce(syl)
	convert_to_alternating_ba_pattern(syl)
	a_powers, b_powers = parse_ab_powers(syl)
	x,y,z = compute_Malcev_coords(a_powers,b_powers,c_counter)

	return (x,y,z)

#word -> word
def fast_Malcify(g): 
	coord = fast_Malcev_coord(g)
	x,y,z = coord[0],coord[1],coord[2]
	return a^x*b^y*c^z
	

