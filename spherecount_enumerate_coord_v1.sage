attach('polynomial_spherecount_v3.sage')

#group element list -> () 
def write_new_file(generating_set):
	with open('sphere words ' + str(generating_set), 'w') as output_file:
		output_file.write('Generating Set: ' + str(generating_set) + '\n\n')

def write_output(generating_set,radius,sphere_words,spherecount):
	with open('sphere words ' + str(generating_set), 'a') as output_file:
		output_file.write('radius: ' + str(radius) + '\n')
		output_file.write('sphere count :' + str(spherecount) + '\n')
		output_file.write('words in sphere: ' + str(sphere_words) + '\n')
		output_file.write('- \n\n')

#(group element list(), int) -> ()
def print_spherecounts(generating_set, end_radius):
	write_new_file(generating_set)
	sphere = generate_new_sphere(generating_set)
	radius = 1
	while radius < end_radius:
		radius, sphere_words, spherecount = sphere.next()
		write_output(generating_set, radius, sphere_words, spherecount)


	

