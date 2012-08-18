from BeautifulSoup import BeautifulSoup
import requests

def get_list_of_company_supporters_of_same_sex_marriage():
    r = requests.get('http://en.wikipedia.org/wiki/List_of_supporters_of_same-sex_marriage_in_the_United_States#Organizations')
    soup = BeautifulSoup(r.text)

    corp = soup.find('span', {'id':'Corporations'})
    div = corp.findParent('h3').findNext('div', {'class': 'column-count column-count-2'})
    lis = div.findAll('li')
    companies = []
    for li in lis:
        a = li.find('a')
        if hasattr(a, 'attrs'):
            for attr in a.attrs:
                if attr[0] == 'title':
                    companies.append(attr[1])

    return companies

companies = get_list_of_company_supporters_of_same_sex_marriage()
for a in companies:
    print a

