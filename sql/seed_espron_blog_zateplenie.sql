-- Seeds the existing "Zateplenie fasády svojpomocne" blog post into the CMS.
-- Run AFTER create_espron_blog_posts.sql.
-- Project ref: ngifengeshwvyzhqvprn.
--
-- Note: custom card/callout blocks from the hand-coded page have been
-- flattened to h2/h3/p/ul so they round-trip through the WYSIWYG editor.
-- Editor authors can format further (bold, links) but structural blocks
-- are intentionally kept simple.

insert into public.espron_blog_posts
  (slug, title, excerpt, category, reading_time, cover_image, content_html, is_published)
values (
  'zateplenie-fasady-svojpomocne',
  'Zateplenie fasády svojpomocne – postup prác krok za krokom',
  'Rozhodli ste sa pre zateplenie domu svojpomocne? Správny technologický postup je kľúčový pre dlhú životnosť, energetickú úsporu a estetický vzhľad fasády. Nižšie nájdete prehľad krokov, porovnanie zateplenia polystyrénom a minerálnou vatou, odporúčané náradie a užitočné tipy pre úspešné zateplenie domu.',
  'Návod',
  '8 min',
  '/images/realizacie/b0408c_2883303b07a4489798740af9878cc2db~mv2.avif',
  $html$<h2>Odporúčané náradie a pomôcky</h2>
<ul>
<li>Murárska lyžica, hladidlo, stierka</li>
<li>Brúsny papier (jemná zrnitosť) alebo brúsna doska</li>
<li>Rezačka (na polystyrén či minerálnu vatu) alebo ostrý nôž</li>
<li>Vŕtačka s miešadlom na prípravu lepidiel</li>
<li>Elektrická vŕtačka (príklepová) alebo skrutkovač na kotvy</li>
<li>Vodováha, laserový alebo klasický meter</li>
<li>Nožnice na mriežku</li>
<li>Vedrá a nádoby na miešanie lepidla, malty a penetrácie</li>
<li>Ochranné pomôcky (rukavice, okuliare, pracovný odev, respirátor)</li>
</ul>

<h2>1. Príprava a povrchové úpravy</h2>
<p><em>(Platí najmä pri zateplení staršieho domu)</em></p>

<h3>Kontrola a odstránenie uvoľnených častí</h3>
<ul>
<li><strong>Vizuálna kontrola:</strong> Dôkladne si prezrite povrch omietky a hľadajte prípadné praskliny, odlupujúce sa alebo inak narušené miesta.</li>
<li><strong>Mechanická kontrola:</strong> Jemnými údermi kladivom skontrolujte, či sa neozýva dutý zvuk naznačujúci odlepenú omietku.</li>
<li><strong>Odstránenie poškodených častí:</strong> Všetky uvoľnené alebo nestabilné miesta opatrne odstráňte (napr. pomocou murárskej lyžice).</li>
</ul>

<h3>Oprava podkladu</h3>
<ul>
<li><strong>Oprava trhlín a dier:</strong> Vyplňte praskliny a poškodenia vhodnými sanačnými alebo výplňovými materiálmi (napr. sanačnou omietkou, opravnou zmesou alebo stierkou odporúčanou výrobcom).</li>
<li><strong>Vyrovnanie povrchu:</strong> Ak je to potrebné, aplikujte vyrovnávaciu stierku, aby bol podklad čo najrovnejší.</li>
</ul>

<h3>Očistenie stien</h3>
<ul>
<li><strong>Odstránenie prachu a nečistôt:</strong> Použite mäkkú metličku alebo kefku, prípadne nízkotlakovú vodu (ak to stav stien dovoľuje).</li>
<li><strong>Odmastenie povrchu:</strong> V prípade mastnôt alebo výrazných nečistôt môžete povrch umyť mydlovou vodou alebo vhodným čistiacim prostriedkom, potom opláchnuť čistou vodou.</li>
<li><strong>Vysušenie:</strong> Pred ďalším postupom (lepenie izolačných dosiek) nechajte stenu dostatočne vyschnúť.</li>
</ul>
<p><strong>Cieľ:</strong> Dosiahnuť čistú, súdržnú a rovnú fasádu pripravenú na ďalšie kroky zateplenia.</p>

<h2>2. Inštalácia základovej lišty a lepenie izolačných dosiek</h2>

<h3>Základová lišta</h3>
<ul>
<li><strong>Presné vymeranie:</strong> Pomocou vodováhy alebo laserového zameriavača si vyznačte na spodnej časti fasády (sokli) rovinu, kde budete lištu upevňovať.</li>
<li><strong>Upevnenie:</strong> Základovú lištu (tzv. zakladaciu alebo soklovú lištu) priložte k vyznačenej línii a prichyťte ju pomocou hmoždiniek a skrutiek. Odporúčaná vzdialenosť medzi upevňovacími bodmi je približne 30 – 40 cm (alebo podľa odporúčaní výrobcu).</li>
<li><strong>Spoje a dilatácie:</strong> Jednotlivé lišty spájajte pomocou spojok, aby ste predišli vzniku medzier a dodržali dilatačné škáry (pri dlhších úsekoch).</li>
<li><strong>Kontrola rovinnosti:</strong> Po upevnení lišty znova skontrolujte, či je lišta vo vodováhe. Táto lišta bude nosná pre prvý rad izolačných dosiek, čím zabezpečíte ich správnu a pevnú polohu.</li>
</ul>

<h3>Lepenie polystyrénu</h3>
<ul>
<li><strong>Príprava lepidla:</strong> Zvoľte lepiacu zmes určenú na fasádny polystyrén a dôkladne ju vymiešajte podľa pokynov výrobcu.</li>
<li><strong>Nanášanie:</strong> Aplikujte lepidlo po celom obvode dosky, čím vytvoríte uzavretý rám. Do stredu dosky pridajte 3 – 4 „buchty&#8220; lepidla, aby bol stred dostatočne podopretý.</li>
<li><strong>Osadenie dosky:</strong> Dosku oprite o základovú lištu a pritlačte k fasáde. Pomocou vodováhy skontrolujte rovinnosť a prípadne dosku vyrovnajte.</li>
<li><strong>Postup lepenia:</strong> Postupujte zdola nahor, pričom v každom ďalšom rade posuňte škáry (podobne ako pri tehlovej väzbe). Tým zabránite vzniku tepelných mostov.</li>
</ul>

<h3>Lepenie minerálnej vaty</h3>
<ul>
<li><strong>Vhodné lepidlo:</strong> Pri minerálnej vate použite špeciálne lepiace hmoty určené priamo na tento druh izolácie.</li>
<li><strong>Nanášanie lepidla:</strong> Rovnako ako pri polystyréne, okolo obvodu dosky a niekoľko bodov do stredu. Dávajte však pozor na rovnomerné pokrytie, pretože minerálna vata je nasiakavá a vyžaduje dôkladnejšiu priľnavosť.</li>
<li><strong>Osadenie a vyrovnanie:</strong> Vatu pevne pritlačte k fasáde a zarovnajte do roviny. Dôležitá je dôsledná priliehavosť dosiek k podkladu a k sebe navzájom.</li>
<li><strong>Hmotnosť a kotvenie:</strong> Minerálna vata je ťažšia a vyžaduje dôkladnejšie kotvenie (viď ďalší krok v postupe).</li>
</ul>

<h3>Porovnanie – Polystyrén</h3>
<ul>
<li>Jednoduchšie rezanie (nôž alebo odporová rezačka)</li>
<li>Nižšia hmotnosť, jednoduchšia manipulácia</li>
<li>Nižšia protipožiarna odolnosť a slabšia zvuková izolácia</li>
</ul>

<h3>Porovnanie – Minerálna vata</h3>
<ul>
<li>Lepšia požiarna odolnosť a zvuková izolácia</li>
<li>Vyššia hmotnosť, potrebné zvýšené kotvenie</li>
<li>Vyššia cena, náročnejšie rezanie</li>
</ul>

<h2>3. Vyplnenie škár</h2>
<p>Škáry do 4 mm vyplňte nízkoexpanznou PUR penou alebo polyuretánovým tmelom určeným na izolácie. Dôkladné vyplnenie škár zabráni vzniku tepelných mostov a zníži riziko vzniku vlhkosti v izolácii.</p>

<h2>4. Brúsenie a kotvenie izolačných dosiek</h2>

<h3>Brúsenie</h3>
<p>Po zaschnutí lepidla (ideálne po 24 hodinách) prebrúste povrch izolačných dosiek (polystyrén alebo minerálnu vatu) brúsnou doskou či jemným brúsnym papierom. Zbavíte sa tak nerovností a pripravíte hladký podklad na stierku.</p>

<h3>Kotvenie</h3>
<ul>
<li>Kotvy (tzv. tanierové hmoždinky) upevňujte do muriva cez izolačné dosky.</li>
<li>Použite minimálne 6 kotiev na 1 m² (alebo viac podľa odporúčaní výrobcu).</li>
<li>Pri minerálnej vate je vhodné zvýšiť počet kotiev alebo použiť kotvy s kovovým tŕňom pre lepšiu nosnosť.</li>
</ul>
<p>Nie ste si istí, či zvládnete zateplenie svojpomocne? Nechajte to na nás. Poskytneme vám profesionálne služby a postaráme sa o kvalitný výsledok. <a href="/kontakt"><strong>Chcem nezáväznú cenovú ponuku →</strong></a></p>

<h2>5. Osadenie profilov a vystuženie rohov otvorov</h2>

<h3>Rohové a dilatačné profily</h3>
<ul>
<li>Vložte ich do čerstvého lepidla alebo malty na miestach, kde hrozí poškodenie fasády – najmä na rohoch budovy, v okolí okien a dverí.</li>
<li>Vyrovnajte ich a dôkladne pritlačte, aby nedochádzalo k deformáciám.</li>
</ul>

<h3>Výstužná mriežka</h3>
<ul>
<li>Na spevnenie okolia okien a dverí použite pásy mriežky s presahom aspoň 10 cm.</li>
<li>Zapracujte ju do lepidla a povrch vyhlaďte stierkou.</li>
</ul>
<p><strong>Tip:</strong> Vyberte si rohové profily s integrovanou mriežkou – ušetríte čas a dosiahnete rovnejšie zakončenia.</p>

<h2>6. Nanášanie a zahladenie lepiacej stierky</h2>

<h3>Prvá vrstva lepidla</h3>
<ul>
<li>Na celý povrch izolačných dosiek (polystyrén alebo vata) naneste súvislú vrstvu lepidla (cca 3 – 4 mm).</li>
<li>Do čerstvého lepidla vložte výstužnú mriežku. Dbajte na to, aby nevznikali záhyby či vrásky.</li>
<li>Nechajte ju mierne zatuhnúť. V závislosti od počasia a odporúčaní výrobcu to môže byť cca 24 hodín.</li>
</ul>

<h3>Druhá vrstva lepidla</h3>
<ul>
<li>Po uplynutí odporúčaného času (keď už prvá vrstva dostatočne drží) aplikujte druhú vrstvu lepidla, aby bola mriežka úplne zakrytá.</li>
<li>Povrch zahlaďte stierkou a skontrolujte rovinu.</li>
</ul>
<p><em>Rozdiel pri minerálnej vate: Vata je nasiakavá, a preto je dôležité dbať na rovnomernú a dostatočnú vrstvu lepidla, aby sa nevytvorili miesta so slabou priľnavosťou.</em></p>

<h2>7. Penetračný náter a fasádna omietka</h2>

<h3>Penetračný náter</h3>
<p>Po úplnom zaschnutí (a vyzretí) lepiacej stierky aplikujte penetračný náter. Ten zlepšuje priľnavosť fasádnej omietky a chráni povrch pred vlhkosťou.</p>

<h3>Fasádna omietka</h3>
<ul>
<li>Po dokonalom vyschnutí penetrácie naneste finálnu fasádnu omietku v súvislej vrstve podľa pokynov výrobcu.</li>
<li>Typ a farbu omietky si zvoľte podľa vašich preferencií a požiadaviek.</li>
</ul>

<h2>Zhrnutie</h2>
<p>Zateplenie domu je komplexný stavebný proces, ktorý zahŕňa prípravu podkladu, lepenie izolačných dosiek (polystyrén alebo minerálna vata), kotvenie, osadenie rohových profilov, aplikáciu výstužnej mriežky, penetračný náter a finálnu fasádnu omietku.</p>
<ul>
<li><strong>Polystyrén</strong> je ľahší, jednoduchšie sa s ním manipuluje a je lacnejší, avšak má horšiu zvukovú izoláciu a horšiu požiarnu odolnosť.</li>
<li><strong>Minerálna vata</strong> je ťažšia, lepšie izoluje hluk, je odolnejšia voči ohňu, ale vyžaduje starostlivejšiu montáž a vyššiu cenu.</li>
</ul>
<p>Pri dôkladnom dodržaní postupov docielite energetickú úsporu, zdravú mikroklímu v interiéri a esteticky príjemnú fasádu s dlhou životnosťou.</p>$html$,
  true
)
on conflict (slug) do update set
  title = excluded.title,
  excerpt = excluded.excerpt,
  category = excluded.category,
  reading_time = excluded.reading_time,
  cover_image = excluded.cover_image,
  content_html = excluded.content_html,
  is_published = excluded.is_published,
  updated_at = now();
