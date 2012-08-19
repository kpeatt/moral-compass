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

domas = get_companies_against_DOMA()
companies = get_list_of_company_supporters_of_same_sex_marriage()

#create a copy of DOMAs
cp = domas[:]
#cleaning up names of companies from DOMA list
for index, val in enumerate(domas):
        name = val.rsplit(' ', 1)[0] #take the last word from a sentence
        cp[index] = name.rstrip(',').rstrip('.').strip('\n').lower() #take off , or . at the end

companies_low = [x.lower() for x in companies] #lowercase the names in companies

#item is a company name from DOMA which is also cleaned up bit
for index, item in enumerate(cp):
    count = 0
    #if item does not match words in a company name from 'companies'
    for comp in companies_low:
        if item not in comp:
            count += 1 #increment count by one
    #if count is equal to length of companies_low, that means it does not exist in the 'companies' list
    if count == len(companies_low):
        #so append, but get the company name from original DOMA list
        companies.append(domas[index].strip('\n'))

#companies is the final list of companies which combines DOMA and ones from Wikipedia
