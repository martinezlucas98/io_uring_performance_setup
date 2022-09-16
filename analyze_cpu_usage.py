import sys

def analyze(input):
    final_arr = list()
    with open(input, "r") as f:
        txt = f.read()
        p_arr = txt.split("\n")
        for p in p_arr:
            arr = p.split(" ")
            column = 0
            for a in arr:
                if a!= None and len(a) > 0:
                    if column == 7:
                        final_arr.append(a)
                    column += 1

    with open(input+"formatted.txt", "w+") as f:
        for cpu in final_arr:
            f.write(cpu+"\n")

    suma = 0
    mini = 10000
    maxi = -1

    for cpu in final_arr[1:]:
        percent = float(cpu.replace(",","."))
        suma += percent
        if percent >= maxi:
            maxi = percent
        if percent <= mini:
            mini = percent

    mean = suma/len(final_arr[1:])
    print(f"Min: {mini}\nMean: {mean}\nMax: {maxi}")

def main(argv):
    try:
        cpu_data = argv[0]
    except Exception:
        print('You must specify path!')
        exit(1)

    analyze(cpu_data)

if __name__ == "__main__":
   main(sys.argv[1:])