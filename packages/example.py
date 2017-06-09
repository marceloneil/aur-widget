from .api import api
from bs4 import BeautifulSoup
from requests import get


def example():
    aur_version = api('cockroachdb-bin')  # Check current aur version

    # Web scraping method
    page = get('https://www.cockroachlabs.com/docs/releases.html').text
    soup = BeautifulSoup(page, 'html.parser')
    tag = soup.find_all('tr', class_="latest")
    official_version = tag[0].a.text

    # GitHub API method
    url = 'https://api.github.com/repos/cockroachdb/cockroach/tags'
    json = get(url).json()
    official_version = json[0]['name']

    if official_version == aur_version:
        return False
    else:
        return True
