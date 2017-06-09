import requests


def api(package):
    params = {'type': 'info', 'v': 5, 'arg[]': package}
    url = 'https://aur.archlinux.org/rpc'
    json = requests.get(url, params=params).json()
    version = json['results'][0]['Version'].replace("-1", "").replace("_", "-")
    return version
