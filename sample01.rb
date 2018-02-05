$op = ''
$people = []

def save
	file = File.open('people.txt', 'w')
	$people.each do |person|
		file.puts person['name']
		file.puts person['age']
	end
	file.flush
	file.close
end

def load
	if File.exist?('people.txt')
		file = File.open('people.txt', 'r')
		$people.clear
		while (line = file.gets) != nil
			line.chomp!
			person = {}
			person['name'] = line
			person['age'] = line = file.gets.chomp.to_i
			$people << person
		end
	end
end

def add
	person = {}
	print 'Nome= '
	person['name'] = gets.chomp
	print 'Idade= '
	person['age'] = gets.chomp.to_i
	$people << person
	save
end

def delete
	$people.delete_at($people.length-1)
	puts 'Apagado!'
	save
end

def list
	$people.each_with_index do |person, index|
		puts "\##{index} - Oii #{person['name']}, tenho #{person['age']} anos"
	end
end

load
begin
	print <<-eos
+---------+
0 - Sair
1 - Cadastrar
2 - Apagar
3 - Listar
+---------+
eos
	print ' => '
	$op = gets.chomp
	case $op
	when '1'
		add
	when '2'
		delete
	when '3'
		list
	when '0'
	else
		puts 'Opção inválida!'
	end
end until $op == '0'

puts 'Bye! :D'