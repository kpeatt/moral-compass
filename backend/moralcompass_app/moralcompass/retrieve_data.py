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

def get_companies_against_DOMA():
    r = requests.get('http://www.huffingtonpost.com/waymon-hudson/over-70-major-companies-f_b_1080485.html')
    soup = BeautifulSoup(r.text)
    soup.find('div', {'class': 'entry_body_text'})
    entry = soup.find('div', {'class': 'entry_body_text'})
    blockquote = entry.findAll('blockquote')[-1]
    corps = blockquote.findAllNext('p')[2].__unicode__().split('<br />')
    companies = []
    for corp in corps:
        if '<p>' in corp:
            companies.append(corp.strip('<p>'))
        elif '</p>' in corp:
            companies.append(corp.strip('</p>'))
        else:
            companies.append(corp)

    return companies

doma = get_companies_against_DOMA()
companies = get_list_of_company_supporters_of_same_sex_marriage()
for a in doma:
    print a
