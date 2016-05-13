require 'mathn.rb'

$eps = 0.0001

def pr(a, b, c, f)
	n = f.length
	a[0] = 0;
	c[n - 1] = 0;
	u = Array.new(f.length)
	alf = Array.new(f.length)
	bet = Array.new(f.length)
	alf[0] = -c[0]/b[0]
	bet[0] = f[0]/b[0]
	for i in (0...n-1)
		alf[i+1] = -c[i]/(alf[i]*a[i] + b[i])
		bet[i+1] = (f[i] - bet[i]*a[i])/(alf[i]*a[i] + b[i])
	end
	u[n-1] =(f[n-1] - bet[n-1]*a[n-1])/(b[n-1] + alf[n-1]*a[n-1])
	for i in (0...n-1).to_a.reverse
		u[i] = alf[i+1]*u[i+1] + bet[i+1]
	end
	return u
end

def presentation(a, b, c, f)
	n = f.length
	puts "Уравнения:"
	s = Array.new(n) do |i|
		Array.new(n) do |j|
			r = 0
			if (i == j + 1) then r = c[i] end
			if (i == j) then r = b[i] end
			if (i + 1 == j) then r = a[i] end
			r = r.to_s + "x#{j}"
		end.join(" + ") + " = " + f[i].to_s
	end
	s.each do |i|
		puts i
	end
end

def test(a, b, c, f, u)
	n = u.length
	for i in (0...n)
		s = 0;
		for j in (0...n)
			r = 0
			if (i == j + 1) then r = a[i] end
			if (i == j) then r = b[i] end
			if (i + 1 == j) then r = c[i] end
			s += r * u[j]
		end
		if (s - f[i]).abs < $eps
			puts "TRUE"
		else
			puts "FALSE #{s.to_f} #{f[i].to_f}"
		end
	end
end

a = Array.new(10) {1}
b = Array.new(10) {4}
c = Array.new(10) {1}
f = Array.new(10) {|i| i+ 1} 

presentation(a, b, c, f)
temp = pr(a, b, c ,f)
for i in (0...temp.length)
	puts "x#{i} = #{temp[i]}"
end
test(a, b, c, f, temp)
p a
p c

