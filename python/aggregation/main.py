import xlrd, xlwt
import re


class PackMat:
    def __init__(self, description, height, width, length):
        self.description = description
        self.height = height
        self.width = width
        self.length = length
        self.group = None

    def assign_group(self, group):
        self.group = group


loc = "./pms.xlsx"
height_buckets, width_buckets, length_buckets = {}, {}, {}

wb = xlrd.open_workbook(loc)
wb2 = xlwt.Workbook("./dimensions.xlsx")
sheet = wb.sheet_by_index(0)

for i in range(sheet.nrows):
    description = sheet.cell_value(i, 0)
    try:
        dimensions = re.search("([0-9]+)(x|X)([0-9]+)(x|X)([0-9]+)", description)
        dimensions = dimensions.group()
        dimensions.split("x")
        # pm = PackMat(dimensions[2], dimensions[1], dimensions[0])
        sheet2 = wb2.add_sheet("Dimension")
        sheet2.write(i, 0, dimensions[2])
        sheet2.write(i, 1, dimensions[1])
        sheet2.write(i, 2, dimensions[0])
    except AttributeError:
        with open("errors.txt", "a", encoding="utf-8") as file:
            file.write(f"{description}\n")

wb2.save("./dimensions.xlsx")
