# https://github.com/streamlink/streamlink/issues/2448#issuecomment-489495542
# pip install --upgrade --user urllib3==1.24.3

from requests_html import HTMLSession
import re
import argparse

parser = argparse.ArgumentParser(description='Resultado da Mega-Sena')

parser.add_argument('--result', dest='accumulate', action='store_const',
                    const=sum, default=max,
                    help='mostra somente somente os números do sorteio')
args = parser.parse_args()

session = HTMLSession()
r = session.get(
    'http://loterias.caixa.gov.br/wps/portal/loterias/landing/megasena').html
r.render(timeout=120)

# from requests_html import HTML
# doc = open("test-nao-acumulou.html", "r").read()
# r = HTML(html=doc)

concurso = r.find('span.ng-binding')[0].text
resultado = '-'.join([x.text for x in r.find('ul.numbers.megasena li')])
acumulou = r.find('h3.epsilon', first=True).attrs
premiacao = r.find('div.related-box', first=True).find('p, h3')

acum = False
if 'ng-hide' not in acumulou['class']:
    acum = True
    print('\x1b[1;48;5;34;97m Acumulou!! \x1b[0m\n')

print(f'\x1b[1m{resultado}\x1b[0m')
re1 = re.match(r'\w+ (\d{4,}) \((\d{2}/\d{2}/\d{4})', concurso)
print(f'Concurso \x1b[1;38;5;46m{re1.group(1)} \x1b[0m{re1.group(2)}\n')

if acum:
    prox_premio = r.find('div.next-prize', first=True).text.split('\n')
    print(prox_premio[0])
    print(f'\x1b[1;105m {prox_premio[1]} \x1b[0m\n')


premiacao_f = []
for p in premiacao:
    if "span" not in p.html:
        if (p.tag == 'h3'):
            if 'ng-hide' not in p.attrs['class']:
                premiacao_f.append(f'\x1b[96m{p.text}\x1b[0m')
        else:
            premiacao_f.append(f'{p.text}\n')
    else:
        premiacao_f.append(f'{p.find("span", first=True).text}\n')

print("\n".join(premiacao_f))
