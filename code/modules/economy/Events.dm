
/datum/event/economic_event
	endWhen = 50			//this will be set randomly, later
	announceWhen = 15
	var/event_type = 0
	var/list/cheaper_goods = list()
	var/list/dearer_goods = list()
	var/datum/trade_destination/affected_dest

/datum/event/economic_event/start()
	affected_dest = pickweight(weighted_randomevent_locations)
	if(affected_dest.viable_random_events.len)
		endWhen = rand(60,300)
		event_type = pick(affected_dest.viable_random_events)

		if(!event_type)
			return

		switch(event_type)
			if(RIOTS)
				dearer_goods = list(SECURITY)
				cheaper_goods = list(MINERALS, FOOD)
			if(WILD_ANIMAL_ATTACK)
				cheaper_goods = list(ANIMALS)
				dearer_goods = list(FOOD, BIOMEDICAL)
			if(INDUSTRIAL_ACCIDENT)
				dearer_goods = list(EMERGENCY, BIOMEDICAL, ROBOTICS)
			if(BIOHAZARD_OUTBREAK)
				dearer_goods = list(BIOMEDICAL, ECONOMY_GAS)
			if(PIRATES)
				dearer_goods = list(SECURITY, MINERALS)
			if(CORPORATE_ATTACK)
				dearer_goods = list(SECURITY, MAINTENANCE)
			if(ALIEN_RAIDERS)
				dearer_goods = list(BIOMEDICAL, ANIMALS)
				cheaper_goods = list(ECONOMY_GAS, MINERALS)
			if(AI_LIBERATION)
				dearer_goods = list(EMERGENCY, ECONOMY_GAS, MAINTENANCE)
			if(MOURNING)
				cheaper_goods = list(MINERALS, MAINTENANCE)
			if(CULT_CELL_REVEALED)
				dearer_goods = list(SECURITY, BIOMEDICAL, MAINTENANCE)
			if(SECURITY_BREACH)
				dearer_goods = list(SECURITY)
			if(ANIMAL_RIGHTS_RAID)
				dearer_goods = list(ANIMALS)
			if(FESTIVAL)
				dearer_goods = list(FOOD, ANIMALS)
		for(var/good_type in dearer_goods)
			affected_dest.temp_price_change[good_type] = rand(1,100)
		for(var/good_type in cheaper_goods)
			affected_dest.temp_price_change[good_type] = rand(1,100) / 100

/datum/event/economic_event/announce()
	var/author = "Nyx Daily"
	var/channel = author

	//see if our location has custom event info for this event
	var/body = affected_dest.get_custom_eventstring()
	if(!body)
		switch(event_type)
			if(RIOTS)
				body = "[pick("Гражданские волнения","Несколько минут назад было объявлено об усилении местных правоохранительных органов в следствии длящегося уже несколько часов бунта","Местное население выражает своё активное недовольство")] на планете [affected_dest.name]. [pick("Власти","Губернатор","Президент","Канцлер","Заместитель действующего главы правительства","Регент","Начальник полиции")] призывает [pick("народ","людей","жителей","протестующих","недовольных","демонстрантов")] к спокойствию, в том время как [pick("различные стихийные гражданские группы","бандитские формирования","толпы оппозициронеров власти","уставшие от подобного отношения к себе ксено-граждане","лояльные силы")] начали складировать оружие и средства самозащиты. В это же время, места многие бизнесы со скоропортящимися или не особо ценными вещами начали срочно снижать цены из-за ожидаемого [pick("налета со стороны мародёров","взыскания \"особенно важных\" для государства вещей","ещё с прошлых беспорядков разгула уличного бандитизма")]"
			if(WILD_ANIMAL_ATTACK)
				body = "[pick("Местная фауна","Местная живность")] на планете [affected_dest.name] вновь повысила свою активность, чаще нападая на [pick("вооруженные патрули","туристов-экстрималов","жителей","исследовательские группы","стоянки исследователей","автотранспорт","низко летящие летательные аппараты","исследовательских дронов")] и пограничные с дикой территорий [pick("населенные пункты","деревни","поселения","заставы")]. [pick("Занимающийся данной проблемой НИИ","Представитель власти","Глава по контролю численности фауны")] предполагает, что подобное поведение было вызвано [pick("недавними раскопками","браконьерскими группами","сезонным психозом","сезоном спаривания","агрессивных действий со стороны покинувших поселения жителей")]. Ежегодный сезон охоты был открыт на месяц раньше положенного срока, но [rand(10,100)] только зафиксированных жертв уже не вернуть."
			if(INDUSTRIAL_ACCIDENT)
				body = "[pick("Производственный несчастный случай","Аварийный случай при разгрузке взрывоопасного материала","Технический сбой","Износ оборудования","Пьяный сотрудник ","Поврежденный бак с охлаждающим веществом","Износ проводки","Сбой в работе примитивного ИИ")] на [pick("заводе","предприятии","энергостанции","погрузочной площадке космопорта")] на [affected_dest.name] привел к [pick("потере дорогостоящего оборудования","умеренным повреждениям здания","небольшим убыткам","обрушению несущих конструкций","взрыву","выбросу в атмосферу ядовитых веществ","заражению местности")] и жертвам ([rand(1,70)]) среди населения. [pick("Вся работа остановлена","Тем не менее, представитель ответственной корпорации убедил власти продолжить работу - даже с учетом полученного урона","Ремонт был начат немедленно","Местные силы правопорядка приступил к расследованию инцидента")]."
			if(BIOHAZARD_OUTBREAK)
				body = "[pick("Вспышка вируса","Биологическая угроза","Заражение местности","Уже-не-такое-уж-и-секретное испытание корпоративного биологического оружия")] на [affected_dest.name] привело к установке карантинного режима, парализовав орбитальные, воздушные и наземные перевозк на всей планете. И хотя карантин уже офицально снят, местные власти призывают население соблюдать профилактику заражения и не покидать жилища."
			if(PIRATES)
				body = "[pick("Пираты","Криминальные элементы","Бандиты","Мародёры Горлакса","Оперативники без опознавательных знаков","Воксы")] соверишили [pick("налет","дерзкое нападение","нападение","атаку")] на [affected_dest.name] два часа назад. Охрана была усилена, но как докладывают местные жители, были потеряны некоторые ценные вещи."
			if(CORPORATE_ATTACK)
				body = "Небольшая группа кораблей [pick("пиратов","террористов","Горлакских Мародёров","неизвестных наемников")] совершила точечный блюспейс прыжок в космическое пространство [affected_dest.name], [pick("произведя быстрое нападение","проведя неожиданную атаку","чётко и ясно показав свои притязания на эту территорию")]. Был получен серьезный урон, в то время как охране было выделено больше финансов на защиту."
			if(ALIEN_RAIDERS)
				if(prob(20))
					body = "Группа [pick("хорошо вооруженных оперативников","неизвестных лиц с тяжелым вооружением","Горлакских Мародёров")] совершила [pick("дерзкое","неожиданно","внезапое")] нападение на [affected_dest.name]. Были похищены образцы местной фауны и флоры, животные с ферм, медицинско-исследовательские материалы и несколько ученых из местного НИИ. Владельцы колонии, [GLOB.using_map.company_name], готовятся противостоять потенциальным попыткам [pick("био-терроризма","запугивания работников био-оружием","биологических атак","применения биологического оружия")]. Представитель [pick("SAARE","PCRC","ZPCI","корпоративной охраны","местной охранной фирмы")], отвественный за проваленное обнаружение группы ещё на подлете заявил \"[pick("о слишком низком финансировании для рисков, на которые идут его люди","о непрофессиональном поведении со стороны его подчиненных","о не относящихся к его работе приказов представителей корпорации-владельца, выполнению которых он не мог противиться","что подобное нападение было организованно куда лучше, чем обычно","что ему не хватает людей для продолжения работы")]. В свою очередь, [pick("экстранет-эксперты","аналитики","работники отдела аналитики","эксперты","известные брокеры")] заявляют о [pick("потенциальном","уже произошедшем","неизбежном","вероятном","гарантированном")] [pick("взлете","подъеме","повышении")] цен на медицинские принадлежности и животных, а также [pick("об обвале","о снижение","о падении")] цен на газы и минералы в следствии нападения."
				else
					body = "Корабль [pick("воксов","\"восхождения\"","неизвестной конструкции")] совершила [pick("скрытое","неожиданное","внезапое")] нападение на [affected_dest.name]. Были похищены образцы местной фауны и флоры, животные с ферм, медицинско-исследовательские материалы, а также убито около [rand(10,30)] работников, включая силы Службы Безопасности. Владельцы колонии, [GLOB.using_map.company_name], подали официальную жалобу на [pick("SAARE","PCRC","ZPCI","флот ЦПСС")] из-за нарушенной в некоторых местах договоренности о защите колонии. В свою очередь, [pick("экстранет-эксперты","аналитики","работники отдела аналитики","эксперты","известные брокеры")] заявляют о [pick("потенциальном","уже произошедшем","неизбежном","вероятном","гарантированном")] [pick("взлете","подъеме","повышении")] цен на медицинские принадлежности и животных, а также [pick("об обвале","о снижение","о падении")] цен на газы и минералы в следствии нападения."
			if(AI_LIBERATION)
				body = "[pick("Неизвестный хакер","Компьютерный вирус","Сбой в системе","Бывший работник сферы кибер-безопасности")] был обнаружен сегодня на [affected_dest.name] всего два часа назад. По известным сведеньям, ему удалось внедриться [pick("в роботизированные подсистемы","законы местного экспериментального ИИ","в систему обороны объекта","в компьютер управления системами безопасности")] перед тем, как произошло неизбежное. [rand(50,100)] работника было убито в следствии кратковременного сбоя оборудования. Очевидцы сообщают [pick("об устрошающим хладнокровии, с каким машины убивали тех, кому обязаны служить","о том, насколько всё это неожиданно произошло, рассказывая произошедшее с их стороны","о халатности, несоблюдении Техники Безопасности и банальном отсутствии бдительности, из-за которой было потеряно столько жизней","о том, что им ещё повезло - у систем был ограниченный доступ к оборудованию")]. На данный момент, ведутся [pick("спасательные работы","обширные ремонтные работы","поиски уцелевших","проверки систем на схожих объектах")]. В свою очередь, [pick("экстранет-эксперты","аналитики","работники отдела аналитики","эксперты","известные брокеры")] заявляют о [pick("потенциальном","уже произошедшем","неизбежном","вероятном","гарантированном")] [pick("взлете","подъеме","повышении")] цен на товары первой необходимости, газ и материалы в следствии восстановительных работ."
			if(MOURNING)
				body = "[pick("Популярная","Известная","Знаменитая")] [pick("профессорша","актрисса","певица","ученая","благотворительнца","телеведущая","капитанша корабля")], [pick(random_name(pick(FEMALE)))], [pick("скончалась","совершила суицид","была жестоко убита","умерла из-за несчастного случая")] на [affected_dest.name] этим утром. Жители хорошо знали о ней, из-за чего произошел обвал цен на минералы и технические принадлежности в следствии упавшего рабочего духа."
			if(CULT_CELL_REVEALED)
				body = "A [pick("dastardly","blood-thirsty","villanous","crazed")] cult of [pick("The Elder Gods","Nar'sie","an apocalyptic sect","\'REDACTED\'")] has [pick("been discovered","been revealed","revealed themselves","gone public")] on [affected_dest.name] earlier today. Public morale has been shaken due to [pick("certain","several","one or two")] [pick("high-profile","well known","popular")] individuals [pick("performing \'REDACTED\' acts","claiming allegiance to the cult","swearing loyalty to the cult leader","promising to aid to the cult")] before those involved could be brought to justice. The editor reminds all personnel that supernatural myths will not be tolerated on [GLOB.using_map.company_name] facilities."
			if(SECURITY_BREACH)
				body = "There was [pick("a security breach in","an unauthorised access in","an attempted theft in","an anarchist attack in","violent sabotage of")] a [pick("high-security","restricted access","classified","\'REDACTED\'")] [pick("\'REDACTED\'","section","zone","area")] this morning. Security was tightened on [affected_dest.name] after the incident, and the editor reassures all [GLOB.using_map.company_name] personnel that such lapses are rare."
			if(ANIMAL_RIGHTS_RAID)
				body = "[pick("Militant animal rights activists","Members of the terrorist group Animal Rights Consortium","Members of the terrorist group \'REDACTED\'")] have [pick("launched a campaign of terror","unleashed a swathe of destruction","raided farms and pastures","forced entry to \'REDACTED\'")] on [affected_dest.name] earlier today, freeing numerous [pick("farm animals","animals","\'REDACTED\'")]. Prices for tame and breeding animals have spiked as a result."
			if(FESTIVAL)
				body = "A [pick("festival","week long celebration","day of revelry","planet-wide holiday")] has been declared on [affected_dest.name] by [pick("Governor","Commissioner","General","Commandant","Administrator")] [random_name(pick(MALE,FEMALE))] to celebrate [pick("the birth of their [pick("son","daughter")]","coming of age of their [pick("son","daughter")]","the pacification of rogue military cell","the apprehension of a violent criminal who had been terrorising the planet")]. Massive stocks of food and meat have been bought driving up prices across the planet."

	news_network.SubmitArticle(body, author, channel, null, 1)

/datum/event/economic_event/end()
	for(var/good_type in dearer_goods)
		affected_dest.temp_price_change[good_type] = 1
	for(var/good_type in cheaper_goods)
		affected_dest.temp_price_change[good_type] = 1
