import packages

updates = 0
update_list = []
for package in dir(packages):
    if ("__" not in package) and ("api" not in package):
        method = getattr(packages, package)
        if method():
            updates += 1
            update_list.append(package.replace("_", "-"))

print(updates)
print(', '.join(update_list))
