function OUTPUT = GenerateARandomNumber(MIN, MAX)

OUTPUT = (MAX-MIN).*rand(1,1) + MIN;
OUTPUT = round(OUTPUT);