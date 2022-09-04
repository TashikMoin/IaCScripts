import json


def generate_dummy(x):
    i = x
    file = open('records.json')
    data = json.load(file)
    for item in data:
        with open("./documents/"+str(i)+".json", "w") as output_file:
            output_file.write(json.dumps(item, indent=4))
        i = i + 1
    file.close()


generate_dummy(0)
generate_dummy(500)
generate_dummy(1000)
