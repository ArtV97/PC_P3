from sys import argv, exit
import random
import json

def main(_foutname):
    with open(_foutname, "w") as f:
        data = {}
        possible_values = [1.0, 2.0, 2.5, 4.0, 5.0, 8.0]
        data["h"] = possible_values[random.randint(0,5)]
        
        possible_values = [0.1, 0.2, 0.25, 0.4, 0.5, 0.8]
        data["r"] = possible_values[random.randint(0,5)]
        
        data["k"] = random.randint(1, 200)
        
        data["h_linha"] = float(f"{((2*data['h'])/(data['r']*data['k'])):.2f}")

        data["t_inf"] = random.randint(100, 300)
        
        data["t_a"] = random.randint(100, 300)
        
        data["t_b"] = random.randint(302, 400)
        
        possible_values = [10.0, 20.0, 25.0, 40.0, 50.0, 80.0, 100.0]
        data["L"] = possible_values[random.randint(0, 6)]

        possible_values = [0.01, 0.1, 0.25, 0.5, 1.0, 2.0]
        data["delta_x"] = possible_values[random.randint(0,5)]
        data["x"] = []

        n = int(data["L"]/data["delta_x"])

        for i in range(n+1):
            xi = float(f"{(i * data['delta_x']):.2f}")
            data["x"].append(xi)

        json.dump(data, f, indent=2)

if __name__ == "__main__":
    argv = argv[1:]
    if len(argv) == 1: main(argv[0])
    else: exit(1)