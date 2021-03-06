app = angular.module 'pistolSearch'

app.factory 'CRITERIA', ['_', 'GUNS', (_, GUNS) ->
	criteria = {}

	criteria.categories = [
		{
			"display" : "Caliber"
			"field" : "caliber"
			"exclusive" : true	# whether more than one value can be true in a category
		}
		{
			"display" : "Frame"
			"field" : "frame"
			"exclusive" : true
		}
		{
			"display" : "Trigger mechanism"
			"field" : "trigger"
			"exclusive" : true
		}
		{
			"display" : "Manufacturer"
			"field" : "manufacturer"
			"exclusive" : true
		}
	]

	###
	populate the categories:
	for each category, go through all the guns and
	find the unique options for the user to choose.
	###
	for category in criteria.categories
		# add a "members" field to each criteria
		category.members = []

		name = category.field;
		for gun in GUNS
			index = _.findIndex criteria.categories, { 'field': name }
			# if it's new, add it:
			if not _.includes criteria.categories[index].members, gun[name]
					criteria.categories[index].members.push gun[name]

	return criteria;
]

app.factory 'PRINTING',->
	printing =
		detailPairs:	# where within a gun's schema to find the details we display in the "Detail" page:
			"Caliber" : 'caliber'
			"Frame material" : 'frame'
			"Trigger mechanism" : 'trigger'
			"Magazine capacity" : 'capacity'
		measurementUnits:
			"barrel" : "in."
			"overall" : "in."
			"height" : "in."
			"width" : "in."
			"weight" : "oz."
		options: [
			{
				"display" : "Front accessory rail"
				"name" : "rail"
			}
			{
				"display" : "Decocker"
				"name" : "decocker"
			}
			{
				"display" : "Threaded barrel"
				"name" : "threaded"
			}
			{
				"display" : "Thumb safety"
				"name" : "safety"
			}
			{
				"display" : "Grip safety"
				"name" : "grip"
			}
			{
				"display" : "Drop safety"
				"name" : "drop"
			}
			{
				"display" : "Trigger safety"
				"name" : "trigger"
			}
			{
				"display" : "Firing pin block"
				"name" : "firing pin"
			}
		]

	return printing;

###
NOTE: The gun data is registered as a separate module
to make it easier to mock in Protractor tests. That I know
of, the simplest way to mock a service is to dump the whole
module and add in a fake one using addMockModule.
###
dataThing = angular.module 'gunData', []

dataThing.factory 'GUNS', ['PRINTING', 'FAMILIES', '$sce', (PRINTING, FAMILIES, $sce) ->
	gunList = [
		{
			"id" : "CZ-75B9"
			"manufacturer" : "CZ"
			"name" : "75 B"
			"subname" : "9mm"
			"description" : "The canonical full-size CZ, available in 9mm or .40 caliber. Full-steel construction and a standard safety. The 'B' indicates a firing pin block is installed, now standard on all CZ-75s."
			"image" : "/img/cz-75b.png"
			"link" : "http://cz-usa.com/product/cz-75-b-9mm-black-16-rd-mags-2/"
			"caliber" : "9mm"
			"frame" : "steel"
			"trigger" : "hammer SA/DA"
			"capacity" : 16
			"magazine" : "double"
			"dimensions" :
				"barrel" : 4.6
				"overall" : 8.1
				"height" : 5.4
				"width" : 1.4
				"weight" : 35
			"options" : [
				"safety"
				"firing pin"
			]
			"youtube" : [
				"https://www.youtube.com/embed/WgDhURHa0OQ"
				"https://www.youtube.com/embed/ybT3wCzzB0M"
			]
			"amazon" : [
				"//ws-na.amazon-adsystem.com/widgets/q?ServiceVersion=20070822&OneJS=1&Operation=GetAdHtml&MarketPlace=US&source=ac&ref=tf_til&ad_type=product_link&tracking_id=pistsear-20&marketplace=amazon&region=US&placement=B005SBMU4K&asins=B005SBMU4K&linkId=J3PSGD2XPJWGWK6P&show_border=true&link_opens_in_new_window=true"
				"//ws-na.amazon-adsystem.com/widgets/q?ServiceVersion=20070822&OneJS=1&Operation=GetAdHtml&MarketPlace=US&source=ac&ref=tf_til&ad_type=product_link&tracking_id=pistsear-20&marketplace=amazon&region=US&placement=B00KZENW2O&asins=B00KZENW2O&linkId=RXFF2MFFIVLWJDIZ&show_border=true&link_opens_in_new_window=true"
				"//ws-na.amazon-adsystem.com/widgets/q?ServiceVersion=20070822&OneJS=1&Operation=GetAdHtml&MarketPlace=US&source=ac&ref=tf_til&ad_type=product_link&tracking_id=pistsear-20&marketplace=amazon&region=US&placement=B00MTY9S1C&asins=B00MTY9S1C&linkId=M2FL3XJRGLMFL4ZD&show_border=true&link_opens_in_new_window=true"
				"//ws-na.amazon-adsystem.com/widgets/q?ServiceVersion=20070822&OneJS=1&Operation=GetAdHtml&MarketPlace=US&source=ac&ref=tf_til&ad_type=product_link&tracking_id=pistsear-20&marketplace=amazon&region=US&placement=B000S5SCPM&asins=B000S5SCPM&linkId=WMH76CSUHY4E2YUN&show_border=true&link_opens_in_new_window=true"
				"//ws-na.amazon-adsystem.com/widgets/q?ServiceVersion=20070822&OneJS=1&Operation=GetAdHtml&MarketPlace=US&source=ac&ref=tf_til&ad_type=product_link&tracking_id=pistsear-20&marketplace=amazon&region=US&placement=B007PAK79C&asins=B007PAK79C&linkId=5FRFYRGNTJNHB5JH&show_border=true&link_opens_in_new_window=true"
				"//ws-na.amazon-adsystem.com/widgets/q?ServiceVersion=20070822&OneJS=1&Operation=GetAdHtml&MarketPlace=US&source=ac&ref=tf_til&ad_type=product_link&tracking_id=pistsear-20&marketplace=amazon&region=US&placement=B00TE3P0R2&asins=B00TE3P0R2&linkId=24T5RNV6TPDIZYBC&show_border=true&link_opens_in_new_window=true"
				"//ws-na.amazon-adsystem.com/widgets/q?ServiceVersion=20070822&OneJS=1&Operation=GetAdHtml&MarketPlace=US&source=ac&ref=tf_til&ad_type=product_link&tracking_id=pistsear-20&marketplace=amazon&region=US&placement=B007ZSKQU4&asins=B007ZSKQU4&linkId=GK7IF3G2QLN6G52T&show_border=true&link_opens_in_new_window=true"
			]
		}
		{
			"id" : "CZ-75B40"
			"variant" : "CZ-75B9"
			"name" : "75 B"
			"subname" : ".40 S&W"
			"caliber" : ".40 S&W"
			"capacity" : 10
			"options" : [
				"safety"
				"firing pin"
			]
			"youtube" : [
				"https://www.youtube.com/embed/PWkYoPhQMwk"
				"https://www.youtube.com/embed/zdXIhHhDpbM"
				"https://www.youtube.com/embed/hsFuqbfiWx4"
			]
		}
		{
			"id" : "CZ-75BD"
			"variant" : "CZ-75B9"
			"name" : "75 BD"
			"description" : "The full-size, all-steel CZ-75, but with the manual safety removed and a decocker in its place."
			"image" : "/img/cz-75bd.png"
			"link" : "http://cz-usa.com/product/cz-75-bd-9mm-black-16-rd-mags/"
			"options" : [
				"decocker"
				"firing pin"
			]
			"youtube" : [
				"https://www.youtube.com/embed/eSlV4BF4ABE"
			]
		}
		{
			"id" : "CZ-75BSA9"
			"variant" : "CZ-75B9"
			"name" : "75 B SA"
			"subname" : "9mm"
			"description" : "The full-size CZ-75, but with a single-action trigger. Available in 9mm or .40."
			"image" : "/img/cz-75bsa.png"
			"link" : "http://cz-usa.com/product/cz-75-b-sa-9mm-black-16-rd-mags/"
			"trigger" : "hammer SA"
			"youtube" : [
				"https://www.youtube.com/embed/BvXbvar8H3c"
				"https://www.youtube.com/embed/jSM2ENTlNFI"
			]
		}
		{
			"id" : "CZ-75BSA40"
			"variant" : "CZ-75BSA9"
			"name" : "75 B SA"
			"subname" : ".40 S&W"
			"caliber" : ".40 S&W"
			"capacity" : 10
		}
		{
			"id" : "CZ-75SP-01"
			"manufacturer" : "CZ"
			"name" : "75 SP-01"
			"description" : "A full-size CZ in 9mm; very similar to the CZ-75B, but with a 1913 accessory rail."
			"image" : "/img/cz-75sp-01.png"
			"link" : "http://cz-usa.com/product/cz-75-sp-01-9mm-black-3-dot-tritium-sights-18-rd-mags/"
			"caliber" : "9mm"
			"frame" : "steel"
			"trigger" : "hammer SA/DA"
			"capacity" : 18
			"magazine" : "double"
			"dimensions" :
				"barrel" : 4.6
				"overall" : 8.15
				"height" : 5.79
				"width" : 1.46
				"weight" : 39
			"options" : [
				"rail"
				"safety"
				"firing pin"
			]
			"youtube" : [
				"https://www.youtube.com/embed/WgDhURHa0OQ"
				"https://www.youtube.com/embed/ybT3wCzzB0M"
			]
		}
		{
			"id" : "CZ-75Bthreaded"
			"manufacturer" : "CZ"
			"name" : "75 B Ω"
			"subname" : "Suppressor-Ready, safety"
			"description" : "A modified CZ 75 B with the new Omega trigger system and a threaded barrel. Includes a standard manual safety that can be swapped out for a decocker."
			"image" : "/img/cz-75bthreaded.png"
			"link" : "http://cz-usa.com/product/cz-75-b-%CF%89-urban-grey-suppressor-ready-omega/"
			"caliber" : "9mm"
			"frame" : "steel"
			"trigger" : "hammer SA/DA"
			"capacity" : 16
			"magazine" : "double"
			"dimensions" :
				"barrel" : 5.2
				"overall" : 8.8
				"height" : 6.1
				"width" : 1.4
				"weight" : 42
			"options" : [
				"safety"
				"firing pin"
				"threaded"
			]
			"youtube" : [
				"https://www.youtube.com/embed/xhAA1w3R0LU"
			]
		}
		{
			"id" : "CZ-75Bthreaded-ns"
			"variant" : "CZ-75Bthreaded"
			"name" : "75 B Ω"
			"subname" : "Suppressor-Ready, decocker"
			"options" : [
				"decocker"
				"firing pin"
				"threaded"
			]
		}
		{
			"id" : "Glock17-4"
			"manufacturer" : "Glock"
			"name" : "17"
			"description" : "The full-size Glock in 9."
			"image" : "/img/glock-17g4.png"
			"link" : "https://us.glock.com/products/model/g17gen4"
			"caliber" : "9mm"
			"frame" : "polymer"
			"trigger" : "striker"
			"capacity" : 17
			"magazine" : "double"
			"dimensions" :
				"barrel" : 4.48
				"overall" : 7.95
				"height" : 5.4
				"width" : 1.18
				"weight" : 25.06
			"options" : [
				"trigger"
				"firing pin"
				"drop"
				"rail"
			]
			"youtube" : [
				"https://www.youtube.com/embed/zkIGtwYwmmk"
				"https://www.youtube.com/embed/V0-GcOZ3Hrc"
				"https://www.youtube.com/embed/nswOxj0RT2s"
			]
			"amazon" : [
				"//ws-na.amazon-adsystem.com/widgets/q?ServiceVersion=20070822&OneJS=1&Operation=GetAdHtml&MarketPlace=US&source=ac&ref=tf_til&ad_type=product_link&tracking_id=pistsear-20&marketplace=amazon&region=US&placement=B016ISRE88&asins=B016ISRE88&linkId=MCB4IHD36N4MAGVN&show_border=true&link_opens_in_new_window=true"
				"//ws-na.amazon-adsystem.com/widgets/q?ServiceVersion=20070822&OneJS=1&Operation=GetAdHtml&MarketPlace=US&source=ac&ref=tf_til&ad_type=product_link&tracking_id=pistsear-20&marketplace=amazon&region=US&placement=B009KQ5R94&asins=B009KQ5R94&linkId=FGUJO3V7XYB4MWAL&show_border=true&link_opens_in_new_window=true"
				"//ws-na.amazon-adsystem.com/widgets/q?ServiceVersion=20070822&OneJS=1&Operation=GetAdHtml&MarketPlace=US&source=ac&ref=tf_til&ad_type=product_link&tracking_id=pistsear-20&marketplace=amazon&region=US&placement=B004AO6BUK&asins=B004AO6BUK&linkId=FD5ZLEASLTOIHHRP&show_border=true&link_opens_in_new_window=true"
			]
		}
		{
			"id" : "Glock19-4"
			"manufacturer" : "Glock"
			"name" : "19"
			"description" : "The compact Glock in 9."
			"image" : "/img/glock-19g4.png"
			"link" : "https://us.glock.com/products/model/g19gen4"
			"caliber" : "9mm"
			"frame" : "polymer"
			"trigger" : "striker"
			"capacity" : 15
			"magazine" : "double"
			"dimensions" :
				"barrel" : 4.01
				"overall" : 7.28
				"height" : 4.99
				"width" : 1.18
				"weight" : 23.65
			"options" : [
				"trigger"
				"firing pin"
				"drop"
				"rail"
			]
			"youtube" : [
				"https://www.youtube.com/embed/nswOxj0RT2s"
				"https://www.youtube.com/embed/V0-GcOZ3Hrc"
				"https://www.youtube.com/embed/3z2w5VlPo3Y"
			]
			"amazon" : [
				"//ws-na.amazon-adsystem.com/widgets/q?ServiceVersion=20070822&OneJS=1&Operation=GetAdHtml&MarketPlace=US&source=ac&ref=tf_til&ad_type=product_link&tracking_id=pistsear-20&marketplace=amazon&region=US&placement=B004AO6BUK&asins=B004AO6BUK&linkId=FD5ZLEASLTOIHHRP&show_border=true&link_opens_in_new_window=true"
			]
		}
		{
			"id" : "Glock26-4"
			"manufacturer" : "Glock"
			"name" : "26"
			"description" : "The \"sub-compact\" Glock in 9."
			"image" : "/img/glock-26g4.png"
			"link" : "https://us.glock.com/products/model/g26gen4"
			"caliber" : "9mm"
			"frame" : "polymer"
			"trigger" : "striker"
			"capacity" : 10
			"magazine" : "double"
			"dimensions" :
				"barrel" : 3.42
				"overall" : 6.41
				"height" : 4.17
				"width" : 1.18
				"weight" : 21.71
			"options" : [
				"trigger"
				"firing pin"
				"drop"
			]
			"youtube" : [
				"https://www.youtube.com/embed/nswOxj0RT2s"
				"https://www.youtube.com/embed/3wHUEwWmklE"
			]
			"amazon" : [
				"//ws-na.amazon-adsystem.com/widgets/q?ServiceVersion=20070822&OneJS=1&Operation=GetAdHtml&MarketPlace=US&source=ac&ref=tf_til&ad_type=product_link&tracking_id=pistsear-20&marketplace=amazon&region=US&placement=B004AO6BUK&asins=B004AO6BUK&linkId=FD5ZLEASLTOIHHRP&show_border=true&link_opens_in_new_window=true"
			]
		}
		{
			"id" : "Glock22-4"
			"manufacturer" : "Glock"
			"name" : "22"
			"description" : "The full-size Glock in .40."
			"image" : "/img/glock-22g4.png"
			"link" : "https://us.glock.com/products/model/g22gen4"
			"caliber" : ".40 S&W"
			"frame" : "polymer"
			"trigger" : "striker"
			"capacity" : 15
			"magazine" : "double"
			"dimensions" :
				"barrel" : 4.48
				"overall" : 7.95
				"height" : 5.43
				"width" : 1.18
				"weight" : 25.59
			"options" : [
				"trigger"
				"firing pin"
				"drop"
				"rail"
			]
			"youtube" : [
				"https://www.youtube.com/embed/R1ePVd6hKeE"
				"https://www.youtube.com/embed/jolIaRoOI_g"
				"https://www.youtube.com/embed/ODt-bW1eD5M"	# also for M&P 40
			]
			"amazon" : [
				"//ws-na.amazon-adsystem.com/widgets/q?ServiceVersion=20070822&OneJS=1&Operation=GetAdHtml&MarketPlace=US&source=ac&ref=tf_til&ad_type=product_link&tracking_id=pistsear-20&marketplace=amazon&region=US&placement=B016ISRE88&asins=B016ISRE88&linkId=MCB4IHD36N4MAGVN&show_border=true&link_opens_in_new_window=true"
				"//ws-na.amazon-adsystem.com/widgets/q?ServiceVersion=20070822&OneJS=1&Operation=GetAdHtml&MarketPlace=US&source=ac&ref=tf_til&ad_type=product_link&tracking_id=pistsear-20&marketplace=amazon&region=US&placement=B009KQ5R94&asins=B009KQ5R94&linkId=FGUJO3V7XYB4MWAL&show_border=true&link_opens_in_new_window=true"
				"//ws-na.amazon-adsystem.com/widgets/q?ServiceVersion=20070822&OneJS=1&Operation=GetAdHtml&MarketPlace=US&source=ac&ref=tf_til&ad_type=product_link&tracking_id=pistsear-20&marketplace=amazon&region=US&placement=B004AO6BUK&asins=B004AO6BUK&linkId=FD5ZLEASLTOIHHRP&show_border=true&link_opens_in_new_window=true"
			]
		}
		{
			"id" : "Glock23-4"
			"manufacturer" : "Glock"
			"name" : "23"
			"description" : "The compact Glock in .40."
			"image" : "/img/glock-23g4.png"
			"link" : "https://us.glock.com/products/model/g23gen4"
			"caliber" : ".40 S&W"
			"frame" : "polymer"
			"trigger" : "striker"
			"capacity" : 13
			"magazine" : "double"
			"dimensions" :
				"barrel" : 4.01
				"overall" : 7.21
				"height" : 4.99
				"width" : 1.18
				"weight" : 23.65
			"options" : [
				"trigger"
				"firing pin"
				"drop"
				"rail"
			]
			"youtube" : [
				"https://www.youtube.com/embed/Tg6RURKEi5Q"
				"https://www.youtube.com/embed/zyX6KCBLbsY"
			]
			"amazon" : [
				"//ws-na.amazon-adsystem.com/widgets/q?ServiceVersion=20070822&OneJS=1&Operation=GetAdHtml&MarketPlace=US&source=ac&ref=tf_til&ad_type=product_link&tracking_id=pistsear-20&marketplace=amazon&region=US&placement=B004AO6BUK&asins=B004AO6BUK&linkId=FD5ZLEASLTOIHHRP&show_border=true&link_opens_in_new_window=true"
			]
		}
		{
			"id" : "Glock27-4"
			"manufacturer" : "Glock"
			"name" : "27"
			"description" : "The \"sub-compact\" Glock in .40."
			"image" : "/img/glock-27g4.png"
			"link" : "https://us.glock.com/products/model/g27gen4"
			"caliber" : ".40 S&W"
			"frame" : "polymer"
			"trigger" : "striker"
			"capacity" : 9
			"magazine" : "double"
			"dimensions" :
				"barrel" : 3.42
				"overall" : 6.41
				"height" : 4.17
				"width" : 1.18
				"weight" : 21.89
			"options" : [
				"trigger"
				"firing pin"
				"drop"
			]
			"youtube" : [
				"https://www.youtube.com/embed/68epOKeo7M8"
				"https://www.youtube.com/embed/hdyq1p7UVAw"
				"https://www.youtube.com/embed/3wHUEwWmklE"
			]
			"amazon" : [
				"//ws-na.amazon-adsystem.com/widgets/q?ServiceVersion=20070822&OneJS=1&Operation=GetAdHtml&MarketPlace=US&source=ac&ref=tf_til&ad_type=product_link&tracking_id=pistsear-20&marketplace=amazon&region=US&placement=B004AO6BUK&asins=B004AO6BUK&linkId=FD5ZLEASLTOIHHRP&show_border=true&link_opens_in_new_window=true"
			]
		}
		{
			"id" : "Glock20-4"
			"manufacturer" : "Glock"
			"name" : "20"
			"description" : "The full-size Glock in 10mm. In lieu of a compact 10mm, Glock offers a \"Glock 20 SF,\" a \"small frame\" Glock 20 with a thinner backstrap but otherwise identical dimensions."
			"image" : "/img/glock-20g4.png"
			"link" : "https://us.glock.com/products/model/g20gen4"
			"caliber" : "10mm"
			"frame" : "polymer"
			"trigger" : "striker"
			"capacity" : 15
			"magazine" : "double"
			"dimensions" :
				"barrel" : 4.6
				"overall" : 8.03
				"height" : 5.47
				"width" : 1.27
				"weight" : 30.71
			"options" : [
				"trigger"
				"firing pin"
				"drop"
				"rail"
			]
			"youtube" : [
				"https://www.youtube.com/embed/kUyf1y50lC4"
				"https://www.youtube.com/embed/yamL7SjaGjE"
				"https://www.youtube.com/embed/-m0satEkGjw"
				"https://www.youtube.com/embed/uCrAaomJS_M"
			]
		}
		{
			"id" : "Glock29-4"
			"manufacturer" : "Glock"
			"name" : "29"
			"description" : "The sub-compact Glock in 10mm. Like the Glock 20, it also comes in a \"small-frame\" variant, the Glock 29 SF, with a reduced backstrap."
			"image" : "/img/glock-29g4.png"
			"link" : "https://us.glock.com/products/model/g29gen4"
			"caliber" : "10mm"
			"frame" : "polymer"
			"trigger" : "striker"
			"capacity" : 10
			"magazine" : "double"
			"dimensions" :
				"barrel" : 1.26
				"overall" : 6.88
				"height" : 4.45
				"width" : 1.27
				"weight" : 26.83
			"options" : [
				"trigger"
				"firing pin"
				"drop"
				"rail"
			]
			"youtube" : [
				"https://www.youtube.com/embed/jaZvjVgy0MM"
				"https://www.youtube.com/embed/VCvJe6QEWNQ"
				"https://www.youtube.com/embed/gVQTgiDyR5k"
			]
		}
		{
			"id" : "Glock21-4"
			"manufacturer" : "Glock"
			"name" : "21"
			"description" : "The full-size Glock in .45. Also comes in a \"small-frame\" version, the Glock 21 SF, that has a smaller backstrap."
			"image" : "/img/glock-21g4.png"
			"link" : "https://us.glock.com/products/model/g21gen4"
			"caliber" : ".45 ACP"
			"frame" : "polymer"
			"trigger" : "striker"
			"capacity" : 13
			"magazine" : "double"
			"dimensions" :
				"barrel" : 4.6
				"overall" : 8.03
				"height" : 5.47
				"width" : 1.27
				"weight" : 29.3
			"options" : [
				"trigger"
				"firing pin"
				"drop"
				"rail"
			]
			"youtube" : [
				"https://www.youtube.com/embed/jo317hYV-ag"	# also springfield xdm
				"https://www.youtube.com/embed/Eynv1q_Ttb0"
				"https://www.youtube.com/embed/iOIHgwVDy-U"
				"https://www.youtube.com/embed/vvHZFNGz7xg"
			]
		}
		{
			"id" : "Glock30-4"
			"manufacturer" : "Glock"
			"name" : "30"
			"description" : "The sub-compact Glock in .45. Also available with a smaller backstrap as the Glock 30 SF, and with a smaller backstrap and slimmer slide as the Glock 30 S."
			"image" : "/img/glock-30g4.png"
			"link" : "https://us.glock.com/products/model/g30gen4"
			"caliber" : ".45 ACP"
			"frame" : "polymer"
			"trigger" : "striker"
			"capacity" : 10
			"magazine" : "double"
			"dimensions" :
				"barrel" : 3.77
				"overall" : 6.88
				"height" : 4.8
				"width" : 1.27
				"weight" : 26.3
			"options" : [
				"trigger"
				"firing pin"
				"drop"
				"rail"
			]
			"youtube" : [
				"https://www.youtube.com/embed/m3b5xuTwZHM"
				"https://www.youtube.com/embed/vvHZFNGz7xg"
				"https://www.youtube.com/embed/5Px_8OPx0ZA"
			]
		}
		{
			"id" : "Glock37-4"
			"manufacturer" : "Glock"
			"name" : "37"
			"description" : "The full-size Glock in .45 G.A.P., the cartridge designed specifically for Glock."
			"image" : "/img/glock-37g4.png"
			"link" : "https://us.glock.com/products/model/g37gen4"
			"caliber" : ".45 GAP"
			"frame" : "polymer"
			"trigger" : "striker"
			"capacity" : 10
			"magazine" : "double"
			"dimensions" :
				"barrel" : 4.48
				"overall" : 7.95
				"height" : 5.51
				"width" : 1.18
				"weight" : 28.95
			"options" : [
				"trigger"
				"firing pin"
				"drop"
				"rail"
			]
			"youtube" : [
				"https://www.youtube.com/embed/q_fCmzIw1WA"
				"https://www.youtube.com/embed/BPbfPmFhWyY"
			]
		}
		{
			"id" : "Glock38"
			"manufacturer" : "Glock"
			"name" : "38"
			"description" : "The compact Glock in .45 G.A.P., the cartridge designed specifically for Glock."
			"image" : "/img/glock-38.png"
			"link" : "https://us.glock.com/products/model/g38"
			"caliber" : ".45 GAP"
			"frame" : "polymer"
			"trigger" : "striker"
			"capacity" : 8
			"magazine" : "double"
			"dimensions" :
				"barrel" : 4.01
				"overall" : 7.36
				"height" : 4.99
				"width" : 1.18
				"weight" : 26.83
			"options" : [
				"trigger"
				"firing pin"
				"drop"
				"rail"
			]
			"youtube" : [
				"https://www.youtube.com/embed/THsIGbgoYiY"
				"https://www.youtube.com/embed/BPbfPmFhWyY"
			]
		}
		{
			"id" : "Glock39"
			"manufacturer" : "Glock"
			"name" : "39"
			"description" : "The sub-compact Glock in .45 G.A.P., the cartridge designed specifically for Glock."
			"image" : "/img/glock-39.png"
			"link" : "https://us.glock.com/products/model/g39"
			"caliber" : ".45 GAP"
			"frame" : "polymer"
			"trigger" : "striker"
			"capacity" : 6
			"magazine" : "double"
			"dimensions" :
				"barrel" : 3.42
				"overall" : 6.49
				"height" : 4.17
				"width" : 1.18
				"weight" : 24.18
			"options" : [
				"trigger"
				"firing pin"
				"drop"
			]
			"youtube" : [
				"https://www.youtube.com/embed/BPbfPmFhWyY"
			]
		}
		{
			"id" : "SW-MP22c"
			"manufacturer" : "S&W"
			"name" : "M&P 22 Compact"
			"description" : "A non-traditional compact S&W in .22 long rifle. Though it has a single-action trigger, the hammer is internal. The slide, rather than steel, is made of aluminum alloy."
			"image" : "/img/sw-mp22c.jpg"
			"link" : "http://www.smith-wesson.com/webapp/wcs/stores/servlet/Product4_750001_750051_833059"
			"caliber" : ".22LR"
			"frame" : "polymer"
			"trigger" : "hammer SA"
			"capacity" : 10
			"magazine" : "single"
			"dimensions" :
				"barrel" : 3.56
				"overall" : 6.65
				"height" : 5.03
				"width" : 1.48
				"weight" : 15.3
			"options" : [
				"magazine safety"
				"safety"
				"rail"
				"threaded"
			]
			"youtube" : [
				"https://www.youtube.com/embed/W5gRlIQy_MA"
				"https://www.youtube.com/embed/EpZx0kpY7SI"
			]
		}
		{
			"id" : "SW-MPshield40"
			"manufacturer" : "S&W"
			"name" : "M&P Shield"
			"subname" : ".40 S&W"
			"description" : "The classic single-stack in .40 S&W. Magazines come in two sizes; the standard holds six rounds, the extended seven."
			"image" : "/img/sw-mp-shield40.jpg"
			"link" : "http://www.smith-wesson.com/webapp/wcs/stores/servlet/Product4_750001_750051_831060"
			"caliber" : ".40 S&W"
			"frame" : "polymer"
			"trigger" : "striker"
			"capacity" : 7
			"magazine" : "single"
			"dimensions" :
				"barrel" : 3.1
				"overall" : 6.1
				"height" : 4.6
				"width" : 0.95
				"weight" : 19.0
			"options" : [

			]
			"youtube" : [
				"https://www.youtube.com/embed/O81wSD7mg0c"
				"https://www.youtube.com/embed/EqBoZaOr33k"
			]
		}
		{
			"id" : "SW-MPshield9"
			"manufacturer" : "S&W"
			"name" : "M&P Shield"
			"subname" : "9mm"
			"description" : "The classic single-stack in .9mm. Like the .40 version, magazines come in two sizes: the standard holds seven rounds, the extended eight."
			"image" : "/img/sw-mp-shield9.jpg"
			"link" : "http://www.smith-wesson.com/webapp/wcs/stores/servlet/Product4_750001_750051_831056"
			"caliber" : "9mm"
			"frame" : "polymer"
			"trigger" : "striker"
			"capacity" : 7
			"magazine" : "single"
			"dimensions" :
				"barrel" : 3.1
				"overall" : 6.1
				"height" : 4.6
				"width" : 0.95
				"weight" : 19.0
			"options" : [

			]
			"youtube" : [
				"https://www.youtube.com/embed/aWWSpVn7NT8"
				"https://www.youtube.com/embed/EqBoZaOr33k"
			]
		}
		{
			"id" : "sw-mp-bodyguard"
			"manufacturer" : "S&W"
			"name" : "M&P Bodyguard"
			"description" : "The sub-compact from S&W that's even smaller than the Shield."
			"image" : "/img/sw-mp-bodyguard.jpg"
			"link" : "http://www.smith-wesson.com/webapp/wcs/stores/servlet/Product4_750001_750051_827563"
			"caliber" : ".380 ACP"
			"frame" : "polymer"
			"trigger" : "hammer DAO"
			"capacity" : 6
			"magazine" : "single"
			"dimensions" :
				"barrel" : 2.75
				"overall" : 5.25
				"height" : 3.78
				"width" : 0.795
				"weight" : 11.85
			"options" : [
				"safety"
			]
			"youtube" : [
				"https://www.youtube.com/embed/fzSS9GzEBd4"
				"https://www.youtube.com/embed/LT81_h980gY"
			]
		}
		{
			"id" : "sw-sd40ve"
			"manufacturer" : "S&W"
			"name" : "SD40 VE"
			"description" : "A next-gen version of the standard S&W SD40, with a \"self-defense trigger\" and an improved slide and grip."
			"image" : "/img/sw-sd40ve.jpg"
			"msrp" : 389
			"link" : "http://www.smith-wesson.com/webapp/wcs/stores/servlet/Product4_750001_750051_811053"
			"caliber" : ".40 S&W"
			"frame" : "polymer"
			"trigger" : "striker"
			"capacity" : 14
			"magazine" : "double"
			"dimensions" :
				"barrel" : 4.0
				"overall" : 7.2
				"height" : 0
				"width" : 1.29
				"weight" : 22.7
			"options" : [
				"trigger"
				"rail"
			]
			"youtube" : [
				"https://www.youtube.com/embed/1cleMs8xmqc"
				"https://www.youtube.com/embed/3rMsAqtQO9s"
				"https://www.youtube.com/embed/6khWQ6PbyeE"
			]
		}
		{
			"id" : "sw-sd9ve"
			"manufacturer" : "S&W"
			"name" : "SD9 VE"
			"description" : "A next-gen version of the standard S&W SD9, with a \"self-defense trigger\" and an improved slide and grip."
			"image" : "/img/sw-sd9ve.jpg"
			"msrp" : 389
			"link" : "http://www.smith-wesson.com/webapp/wcs/stores/servlet/Product4_750001_750051_811049"
			"caliber" : "9mm"
			"frame" : "polymer"
			"trigger" : "striker"
			"capacity" : 16
			"magazine" : "double"
			"dimensions" :
				"barrel" : 4.0
				"overall" : 7.2
				"height" : 0
				"width" : 1.29
				"weight" : 22.7
			"options" : [
				"trigger"
				"rail"
			]
			"youtube" : [
				"https://www.youtube.com/embed/xpW7rdTJpBE"
				"https://www.youtube.com/embed/7thRJU-wz5s"
			]
		}
		{
			"id" : "sw-1911-9"
			"manufacturer" : "S&W"
			"name" : "SW1911"
			"subname" : "9mm"
			"description" : "S&W's 1911 in 9mm."
			"image" : "/img/sw-1911-9.jpg"
			"msrp" : 1579
			"link" : "http://www.smith-wesson.com/webapp/wcs/stores/servlet/Product4_750001_750051_766209"
			"caliber" : "9mm"
			"frame" : "steel"
			"trigger" : "hammer SA"
			"capacity" : 10
			"magazine" : "single"
			"dimensions" :
				"barrel" : 5.0
				"overall" : 8.7
				"height" : 0
				"width" : 0
				"weight" : 41.0
			"options" : [
				"safety"
				"grip"
			]
			"youtube" : [
				"https://www.youtube.com/embed/zv_xcebzXyI"
			]
		}
		{
			"id" : "sw-1911pro"
			"variant" : "sw-1911-9"
			"name" : "SW1911 Pro Series"
			"description" : "A 9mm 1911-style handgun; the \"pro series\" is described by S&W as \"completing the line between main production and the Performance Center,\" essentially an enhanced version of the standard SW1911."
			"image" : "/img/sw-1911pro.jpg"
			"msrp" : 1609
			"link" : "http://www.smith-wesson.com/webapp/wcs/stores/servlet/Product4_750001_750051_789547"
			"youtube" : [
				"https://www.youtube.com/embed/TgY1oKF0cbE"
				"https://www.youtube.com/embed/zrBF4MFNe4s"
			]
		}
		{
			"id" : "sw-1911-45"
			"variant" : "sw-1911-9"
			"name" : "SW1911"
			"subname" : ".45 ACP"
			"description" : "S&W's 1911 in .45 ACP. Comes with either a five- or three-inch barrel."
			"image" : "/img/sw-1911-45.jpg"
			"msrp" : 1459
			"link" : "http://www.smith-wesson.com/webapp/wcs/stores/servlet/Product4_750001_750051_765953"
			"caliber" : ".45 ACP"
			"capacity" : 8
			"youtube" : [
				"https://www.youtube.com/embed/QSS8tI1vnYY"
				"https://www.youtube.com/embed/5mGC-ZxggHA"
			]
		}
		{
			"id" : "sw-1911-45-3"
			"variant" : "sw-1911-45"
			"name" : "SW1911"
			"subname" : ".45 ACP, 3\" barrel"
			"image" : "/img/sw-1911-45-3.jpg"
			"msrp" : 1229
			"link" : "http://www.smith-wesson.com/webapp/wcs/stores/servlet/Product4_750001_750051_766210"
			"dimensions" :
				"barrel" : 3.0
				"overall" : 6.9
				"height" : 0
				"width" : 0
				"weight" : 26.5
			"youtube" : [
				"https://www.youtube.com/embed/W44cdYF2RXg"
			]
		}
		{
			"id" : "sw-model41"
			"manufacturer" : "S&W"
			"name" : "Model 41"
			"description" : "A high-end rimfire target pistol with a trigger pull at less than 3 pounds, designed with competition shooters in mind. A 5.5-inch barrel is standard, but can be swapped out for a 7-inch version."
			"image" : "/img/sw-model41.jpg"
			"msrp" : 1369
			"link" : "http://www.smith-wesson.com/webapp/wcs/stores/servlet/Product4_750001_750051_764921"
			"caliber" : ".22LR"
			"frame" : "carbon steel"
			"trigger" : "hammer SA"
			"capacity" : 10
			"magazine" : "single"
			"dimensions" :
				"barrel" : 5.5
				"overall" : 10.5
				"height" : 0
				"width" : 0
				"weight" : 41.0
			"options" : [
				"safety"
			]
			"youtube" : [
				"https://www.youtube.com/embed/a_kzs01U1l8"
				"https://www.youtube.com/embed/yAVE9qGYm1g"
			]
		}
		{
			"id" : "sw-mp40"
			"manufacturer" : "S&W"
			"name" : "M&P 40"
			"description" : "The tried-and-true service pistol from S&W."
			"image" : "/img/sw-mp40.jpg"
			"msrp" : 569
			"link" : "http://www.smith-wesson.com/webapp/wcs/stores/servlet/Product4_750001_750051_765389"
			"caliber" : ".40 S&W"
			"frame" : "polymer"
			"trigger" : "striker"
			"capacity" : 15
			"magazine" : "double"
			"dimensions" :
				"barrel" : 4.25
				"overall" : 7.63
				"height" : 5.5
				"width" : 1.2
				"weight" : 24.25
			"options" : [
				"safety"
				"trigger"
				"rail"
			]
			"youtube" : [
				"https://www.youtube.com/embed/hrFkXCUwGDM"
				"https://www.youtube.com/embed/hZZad6KmfMY"
			]
		}
		{
			"id" : "sw-mp40c"
			"manufacturer" : "S&W"
			"name" : "M&P Compact .40"
			"description" : "The tried-and-true service pistol from S&W. Comes with or without a thumb safety."
			"image" : "/img/sw-mp40c.jpg"
			"msrp" : 569
			"link" : "http://www.smith-wesson.com/webapp/wcs/stores/servlet/Product4_750001_750051_766227"
			"caliber" : ".40 S&W"
			"frame" : "polymer"
			"trigger" : "striker"
			"capacity" : 10
			"magazine" : "double"
			"dimensions" :
				"barrel" : 3.5
				"overall" : 6.7
				"height" : 4.3
				"width" : 1.2
				"weight" : 21.9
			"options" : [
				"trigger"
				"safety"
				"rail"
			]
			"youtube" : [
				"https://www.youtube.com/embed/OLFAt63aNbY"
				"https://www.youtube.com/embed/pvBVCQBUnLs"
			]
		}
		{
			"id" : "sw-mp40c-ns"
			"variant" : "sw-mp40c"
			"name" : "M&P Compact .40"
			"subname" : "no safety"
			"image" : "/img/sw-mp40c-ns.jpg"
			"link" : "http://www.smith-wesson.com/webapp/wcs/stores/servlet/Product4_750001_750051_765698"
			"options" : [
				"trigger"
				"rail"
			]
		}
		{
			"id" : "sw-mp45"
			"manufacturer" : "S&W"
			"name" : "M&P45"
			"subname" : "4.5-inch barrel"
			"description" : "The popular, classic M&P handgun chambered in .45 ACP. Comes in models with or without a thumb safety, and barrels either 4 inches long or 4.5."
			"image" : "/img/sw-mp45.jpg"
			"msrp" : 619
			"link" : "http://www.smith-wesson.com/webapp/wcs/stores/servlet/Product4_750001_750051_765773"
			"caliber" : ".45 ACP"
			"frame" : "polymer"
			"trigger" : "striker"
			"capacity" : 10
			"magazine" : "double"
			"dimensions" :
				"barrel" : 4.5
				"overall" : 8.05
				"height" : 0
				"width" : 0
				"weight" : 29.6
			"options" : [
				"safety"
				"trigger"
				"rail"
			]
			"youtube" : [
				"https://www.youtube.com/embed/sxXQtLMNGqI"
				"https://www.youtube.com/embed/piDK0xjlLGs"
			]
		}
		{
			"id" : "sw-mp45-4"
			"variant" : "sw-mp45"
			"name" : "M&P45"
			"subname" : "4-inch barrel"
			"image" : "/img/sw-mp45-4.jpg"
			"link" : "http://www.smith-wesson.com/webapp/wcs/stores/servlet/Product4_750001_750051_765736"
			"dimensions" : {
				"barrel" : 4.0
				"overall" : 7.55
				"height" : 0
				"width" : 0
				"weight" : 27.7
			}
		}
		{
			"id" : "sw-mp45ns-4"
			"variant" : "sw-mp45-4"
			"name" : "M&P45"
			"subname" : "4-inch barrel, no safety"
			"image" : "/img/sw-mp45ns-4.jpg"
			"msrp" : 599
			"link" : "http://www.smith-wesson.com/webapp/wcs/stores/servlet/Product4_750001_750051_765739"
			"options" : [
				"trigger"
				"rail"
			]
		}
		{
			"id" : "sw-mp45ns"
			"variant" : "sw-mp45"
			"image" : "/img/sw-mp45ns.jpg"
			"msrp" : 599
			"link" : "http://www.smith-wesson.com/webapp/wcs/stores/servlet/Product4_750001_750051_765778"
			"options" : [
				"trigger"
				"rail"
			]
		}
		{
			"id" : "sw-mp45c"
			"manufacturer" : "S&W"
			"name" : "M&P45c"
			"description" : "A compact version of the popular, classic M&P handgun chambered in .45 ACP. Comes in models with or without a thumb safety."
			"image" : "/img/sw-mp45c.jpg"
			"msrp" : 619
			"link" : "http://www.smith-wesson.com/webapp/wcs/stores/servlet/Product4_750001_750051_766269"
			"caliber" : ".45 ACP"
			"frame" : "polymer"
			"trigger" : "striker"
			"capacity" : 8
			"magazine" : "double"
			"dimensions" :
				"barrel" : 4.0
				"overall" : 7.55
				"height" : 0
				"width" : 1.2
				"weight" : 26.2
			"options" : [
				"trigger"
				"rail"
			]
			"youtube" : [
				"https://www.youtube.com/embed/piDK0xjlLGs"
				"https://www.youtube.com/embed/4UBhQpvEPTU"
			]
		}
		{
			"id" : "sw-mp45c-ns"
			"variant" : "sw-mp45c"
			"name" : "M&P45c"
			"subname" : "no safety"
			"image" : "/img/sw-mp45c-ns.jpg"
			"msrp" : 599
			"link" : "http://www.smith-wesson.com/webapp/wcs/stores/servlet/Product4_750001_750051_766268"
			"options" : [
				"trigger"
				"rail"
			]
		}
		{
			"id" : "sw-mp357c"
			"manufacturer" : "S&W"
			"name" : "M&P Compact"
			"subname" : ".357 Sig"
			"discontinued" : true
			"description" : "A discontinued version of the M&P Compact chambered in .357 Sig."
			"image" : "/img/sw-mp357c.jpg"
			"msrp" : 727
			"link" : "http://www.smith-wesson.com/webapp/wcs/stores/servlet/Product4_750001_750051_765760"
			"caliber" : ".357 Sig"
			"frame" : "polymer"
			"trigger" : "striker"
			"capacity" : 10
			"magazine" : "double"
			"dimensions" :
				"barrel" : 3.5
				"overall" : 6.7
				"height" : 4.3
				"width" : 1.2
				"weight" : 22.2
			"options" : [
				"trigger"
				"rail"
			]
			"youtube" : [
				"https://www.youtube.com/embed/MtuGiBSm4Vs"

			]
		}
		{
			"id" : "sw-mp357"
			"manufacturer" : "S&W"
			"name" : "M&P357"
			"discontinued" : true
			"description" : "A discontinued version of the M&P chambered in .357 Sig."
			"image" : "/img/sw-mp357.jpg"
			"msrp" : 727
			"link" : "http://www.smith-wesson.com/webapp/wcs/stores/servlet/Product4_750001_750051_766225"
			"caliber" : ".357 Sig"
			"frame" : "polymer"
			"trigger" : "striker"
			"capacity" : 15
			"magazine" : "double"
			"dimensions" :
				"barrel" : 4.25
				"overall" : 7.63
				"height" : 0
				"width" : 0
				"weight" : 25.5
			"options" : [
				"trigger"
				"thumb"
				"rail"
			]
			"youtube" : [
				"https://www.youtube.com/embed/tk3b42A-NQQ"
			]
		}
		{
			"id" : "sw-mp9"
			"manufacturer" : "S&W"
			"name" : "M&P9"
			"description" : "The M&P9, which comes either with or without a thumb safety"
			"image" : "/img/sw-mp9.jpg"
			"msrp" : 569
			"link" : "http://www.smith-wesson.com/webapp/wcs/stores/servlet/Product4_750001_750051_766223"
			"caliber" : "9mm"
			"frame" : "polymer"
			"trigger" : "striker"
			"capacity" : 17
			"magazine" : "double"
			"dimensions" :
				"barrel" : 4.25
				"overall" : 7.63
				"height" : 0
				"width" : 0
				"weight" : 24.0
			"options" : [
				"thumb"
				"trigger"
				"rail"
			]
			"youtube" : [
				"https://www.youtube.com/embed/Dh1nsoPxE-Q"
			]
		}
		{
			"id" : "sw-mp9-ns"
			"variant" : "sw-mp9"
			"name" : "M&P9"
			"subname" : "no safety"
			"image" : "/img/sw-mp9-ns.jpg"
			"msrp" : 569
			"link" : "http://www.smith-wesson.com/webapp/wcs/stores/servlet/Product4_750001_750051_770002"
			"options" : [
				"trigger"
			]
		}
		{
			"id" : "sw-mp9pro"
			"manufacturer" : "S&W"
			"name" : "M&P9 Pro Series"
			"description" : "The more upscale version of the standard M&P9, with an extended slide and upgraded sights. (Also does not have a mag safety.)"
			"image" : "/img/sw-mp9p.jpg"
			"msrp" : 689
			"link" : "http://www.smith-wesson.com/webapp/wcs/stores/servlet/Product4_750001_750051_765952"
			"caliber" : "9mm"
			"frame" : "polymer"
			"trigger" : "striker"
			"capacity" : 17
			"magazine" : "double"
			"dimensions" :
				"barrel" : 5.0
				"overall" : 8.5
				"height" : 0
				"width" : 0
				"weight" : 26.0
			"options" : [
				"trigger"
				"rail"
			]
			"youtube" : [
				"https://www.youtube.com/embed/Dh1nsoPxE-Q"
			]
		}
		{
			"id" : "sw-mp9c"
			"manufacturer" : "S&W"
			"name" : "M&P9c"
			"description" : "The compact version of the M&P9, which comes either with or without a thumb safety"
			"image" : "/img/sw-mp9c.jpg"
			"msrp" : 569
			"link" : "http://www.smith-wesson.com/webapp/wcs/stores/servlet/Product4_750001_750051_766226"
			"caliber" : "9mm"
			"frame" : "polymer"
			"trigger" : "striker"
			"capacity" : 12
			"magazine" : "double"
			"dimensions" :
				"barrel" : 3.5
				"overall" : 6.7
				"height" : 0
				"width" : 0
				"weight" : 21.7
			"options" : [
				"thumb"
				"trigger"
				"rail"
			]
			"youtube" : [
				"https://www.youtube.com/embed/WFv3W8TOw1A"
				"https://www.youtube.com/embed/6V7CogUc4nk"
			]
		}
		{
			"id" : "sw-mp9c-ns"
			"variant" : "sw-mp9c"
			"name" : "M&P9c"
			"subname" : "no safety"
			"image" : "/img/sw-mp9c-ns.jpg"
			"msrp" : 569
			"link" : "http://www.smith-wesson.com/webapp/wcs/stores/servlet/Product4_750001_750051_770008"
			"options" : [
				"trigger"
				"rail"
			]
		}
		{
			"id" : "beretta-92fs"
			"manufacturer" : "Beretta"
			"name" : "92 FS"
			"description" : "Beretta's bread and butter. The civilian version of the U.S. military's M9 sidearm. (Available without a safety as the 92 G.)"
			"image" : "/img/beretta-92fs.jpg"
			"msrp" : 675
			"link" : "http://www.beretta.com/en-us/92-fs/"
			"caliber" : "9mm"
			"frame" : "aluminum alloy"
			"trigger" : "hammer SA/DA"
			"capacity" : 15
			"magazine" : "double"
			"dimensions" :
				"barrel" : 4.9
				"overall" : 8.5
				"height" : 5.4
				"width" : 1.5
				"weight" : 33.3
			"options" : [
				"safety"
				"decocker"
			]
			"youtube" : [
				"https://www.youtube.com/embed/S4kkckLFl5g"
				"https://www.youtube.com/embed/_BOMmIvMRm8"
			]
		}
		{
			"id" : "beretta-92brigadier"
			"variant" : "beretta-92fs"
			"name" : "92 Brigadier"
			"description" : "A modified 92FS handgun with wraparound Hogue grips and a heavier slide, with the stated aim of reducing felt recoil."
			"image" : "/img/beretta-92brigadier.png"
			"msrp" : 825
			"link" : "http://www.beretta.com/en-us/92-brigadier/"
		}
		{
			"id" : "beretta-92g"
			"variant" : "beretta-92fs"
			"name" : "92 G"
			"description" : "A modified 92 FS that has a decocker but no thumb safety."
			"image" : "/img/beretta-92g.jpg"
			"link" : "http://www.beretta.com/en-us/92-g/"
			"options" : [
				"firing pin block"
				"decocker"
			]
			"youtube" : [
				"https://www.youtube.com/embed/S4kkckLFl5g"
				"https://www.youtube.com/embed/_BOMmIvMRm8"
			]
		}
		{
			"id" : "beretta-m9a3"
			"manufacturer" : "Beretta"
			"name" : "M9A3"
			"description" : "An enhanced \"tactical\" version of the 92 FS, the M9A3 features a decocker (and optional safety), a threaded barrel and enlarged magazine release button. Available with or without a thumb safety."
			"image" : "/img/beretta-m9a3.jpg"
			"msrp" : 1099
			"link" : "http://www.beretta.com/en-us/m9a3/"
			"caliber" : "9mm"
			"frame" : "aluminum alloy"
			"trigger" : "hammer SA/DA"
			"capacity" : 17
			"magazine" : "double"
			"dimensions" :
				"barrel" : 4.9
				"overall" : 8.5
				"height" : 5.4
				"width" : 1.5
				"weight" : 33.9
			"options" : [
				"firing pin block"
				"decocker"
				"threaded"
				"safety"
				"rail"
			]
			"youtube" : [
				"https://www.youtube.com/embed/jincc8cQtDo"
				"https://www.youtube.com/embed/HkQJca15CYk"
			]
		}
		{
			"id" : "beretta-m9a3-ns"
			"variant" : "beretta-m9a3"
			"name" : "M9A3"
			"subname" : "no safety"
			"image" : "/img/beretta-m9a3.jpg"
			"options" : [
				"firing pin block"
				"decocker"
				"threaded"
				"rail"
			]
		}
		{
			"id" : "beretta-96a1"
			"variant" : "beretta-92fs"
			"name" : "96A1"
			"description" : "A 92FS-style handgun, chambered in .40 S&W."
			"image" : "/img/beretta-96a1.jpg"
			"msrp" : 775
			"link" : "http://www.beretta.com/en-us/96-a1/"
			"caliber" : ".40 S&W"
			"capacity" : 12
			"options" : [
				"firing pin block"
				"decocker"
				"safety"
				"rail"
			]
			"youtube" : [
				"https://www.youtube.com/embed/c6GiamFFjME"
			]
		}
		{
			"id" : "beretta-m9-22"
			"manufacturer" : "Beretta"
			"name" : "M9-22"
			"description" : "An \"exact replica\" of the Beretta M9 (and 92 FS) chambered in .22 long rifle."
			"image" : "/img/beretta-m9-22.png"
			"msrp" : 430
			"link" : "http://www.beretta.com/en-us/m9-22lr/"
			"caliber" : ".22LR"
			"frame" : "aluminum alloy"
			"trigger" : "hammer SA/DA"
			"capacity" : 15
			"magazine" : "single"
			"dimensions" :
				"barrel" : 4.9
				"overall" : 8.5
				"height" : 5.4
				"width" : 1.52
				"weight" : 26.08
			"options" : [
				"safety"
				"decocker"
			]
			"youtube" : [
				"https://www.youtube.com/embed/TY4s9HVhu44"
			]
		}
		{
			"id" : "ruger-lcp"
			"manufacturer" : "Ruger"
			"name" : "LCP"
			"description" : "A .380 pocket pistol with an optional Crimson Trace laser sight. Available with a blued steel slide or one in stainless. Available with 6- or 7-round magazines. IMPORTANT NOTE: Ruger classifies the LCP's trigger action as \"single-strike double-action,\" described here as within the broader single-action category because the trigger can only be pulled after racking the slide. The trigger can't be pulled twice on a round that failed to fire."
			"image" : "/img/ruger-lcp.jpg"
			"msrp" : 259
			"link" : "http://ruger.com/products/lcp/specSheets/3701.html"
			"caliber" : ".380 ACP"
			"frame" : "polymer"
			"trigger" : "hammer SA"
			"capacity" : 7
			"magazine" : "single"
			"dimensions" :
				"barrel" : 2.75
				"overall" : 5.16
				"height" : 3.6
				"width" : 0.82
				"weight" : 9.6
			"options" : [

			]
			"youtube" : [
				"https://www.youtube.com/embed/QrE371hU8m4"
				"https://www.youtube.com/embed/EvVi5DQF9X4"
				"https://www.youtube.com/embed/e9FwISjVuT4"
			]
		}
		{
			"id" : "ruger-lc9s"
			"manufacturer" : "Ruger"
			"name" : "LC9s"
			"description" : "Ruger's compact 9mm, the striker-fired variety. Available with or without a manual safety."
			"image" : "/img/ruger-lc9s.jpg"
			"msrp" : 479
			"link" : "http://ruger.com/products/lc9s/specSheets/3235.html"
			"caliber" : "9mm"
			"frame" : "polymer"
			"trigger" : "striker"
			"capacity" : 7
			"magazine" : "single"
			"dimensions" :
				"barrel" : 3.12
				"overall" : 6
				"height" : 4.5
				"width" : 0.9
				"weight" : 17.2
			"options" : [
				"safety"
				"magazine safety"
			]
			"youtube" : [
				"https://www.youtube.com/embed/Opx_IFm0iQU"
			]
		}
		{
			"id" : "ruger-lc9s-pro"
			"manufacturer" : "Ruger"
			"name" : "LC9s Pro"
			"description" : "Ruger's compact 9mm, the striker-fired variety. Available with or without a manual safety."
			"image" : "/img/ruger-lc9s.jpg"
			"msrp" : 479
			"link" : "http://ruger.com/products/lc9s/specSheets/3248.html"
			"caliber" : "9mm"
			"frame" : "polymer"
			"trigger" : "striker"
			"capacity" : 7
			"magazine" : "single"
			"dimensions" :
				"barrel" : 3.12
				"overall" : 6
				"height" : 4.5
				"width" : 0.9
				"weight" : 17.2
			"options" : [

			]
			"youtube" : [
				"https://www.youtube.com/embed/p2bBSHxk-Oc"
			]
		}
		{
			"id" : "ruger-lc380"
			"manufacturer" : "Ruger"
			"name" : "LC380"
			"description" : "The exact dimensions of the 9mm LC9s, but chambered in .380. Larger than Ruger's other .380, the LCP."
			"image" : "/img/ruger-lc380.jpg"
			"msrp" : 479
			"link" : "http://ruger.com/products/lc380/specSheets/3219.html"
			"caliber" : "9mm"
			"frame" : "polymer"
			"trigger" : "striker"
			"capacity" : 7
			"magazine" : "single"
			"dimensions" :
				"barrel" : 3.12
				"overall" : 6
				"height" : 4.5
				"width" : 0.9
				"weight" : 17.2
			"options" : [

			]
			"youtube" : [
				"https://www.youtube.com/embed/EXy9Nd2InyI"
				"https://www.youtube.com/embed/6XycvZKmcTs"
			]
		}
		{
			"id" : "ruger-9e"
			"manufacturer" : "Ruger"
			"name" : "9E"
			"description" : "Ruger's lower-cost alternative to the full-size SR9."
			"image" : "/img/ruger-9e.jpg"
			"msrp" : 459
			"link" : "http://ruger.com/products/9E/specSheets/3340.html"
			"caliber" : "9mm"
			"frame" : "polymer"
			"trigger" : "striker"
			"capacity" : 17
			"magazine" : "double"
			"dimensions" :
				"barrel" : 4.14
				"overall" : 7.5
				"height" : 5.53
				"width" : 1.27
				"weight" : 27.2
			"options" : [
				"safety"
				"rail"
			]
			"youtube" : [
				"https://www.youtube.com/embed/a2zlfdqTNr0"
				"https://www.youtube.com/embed/3R2Usxu7fvk"
				"https://www.youtube.com/embed/R8XCCDV4O1w"
			]
		}
		{
			"id" : "ruger-sr9"
			"manufacturer" : "Ruger"
			"name" : "SR9"
			"description" : "Ruger's full-size 9mm. Slide available either in stainless steel or with a black nitride finish."
			"image" : "/img/ruger-sr9.jpg"
			"msrp" : 569
			"link" : "http://ruger.com/products/sr9/specSheets/3301.html"
			"caliber" : "9mm"
			"frame" : "polymer"
			"trigger" : "striker"
			"capacity" : 17
			"magazine" : "double"
			"dimensions" :
				"barrel" : 4.14
				"overall" : 7.5
				"height" : 5.52
				"width" : 1.27
				"weight" : 26.5
			"options" : [
				"safety"
				"rail"
			]
			"youtube" : [
				"https://www.youtube.com/embed/ysokL6pHf1I"
				"https://www.youtube.com/embed/apzCB-gLAPg"
				"https://www.youtube.com/embed/E1YMWh94L84"
			]
		}
		{
			"id" : "ruger-sr9c"
			"manufacturer" : "Ruger"
			"name" : "SR9c"
			"description" : "The compact version of the SR9. Slide available either in stainless steel or with a black nitride finish. Also ships with a full-size 17-round magazine and slip-on grip extension."
			"image" : "/img/ruger-sr9c.jpg"
			"msrp" : 569
			"link" : "http://ruger.com/products/sr9c/specSheets/3313.html"
			"caliber" : "9mm"
			"frame" : "polymer"
			"trigger" : "striker"
			"capacity" : 10
			"magazine" : "double"
			"dimensions" :
				"barrel" : 3.4
				"overall" : 6.85
				"height" : 4.61
				"width" : 1.27
				"weight" : 23.4
			"options" : [
				"safety"
				"rail"
				"magazine safety"
			]
			"youtube" : [
				"https://www.youtube.com/embed/zT1q1C_PnIY"
				"https://www.youtube.com/embed/XjP_Mj4P4Y8"
				"https://www.youtube.com/embed/vyP5gEjQ58g"
				"https://www.youtube.com/embed/lpj9Pwv6TTY"
			]
		}
		{
			"id" : "ruger-sr40"
			"manufacturer" : "Ruger"
			"name" : "SR40"
			"description" : "Ruger's .40 caliber full-size handgun. Almost identical dimensions to the 9mm version, the SR9."
			"image" : "/img/ruger-sr40.jpg"
			"msrp" : 569
			"link" : "http://ruger.com/products/sr40/specSheets/3470.html"
			"caliber" : ".40 S&W"
			"frame" : "polymer"
			"trigger" : "striker"
			"capacity" : 15
			"magazine" : "double"
			"dimensions" :
				"barrel" : 4.14
				"overall" : 7.5
				"height" : 5.52
				"width" : 1.27
				"weight" : 27.2
			"options" : [
				"safety"
				"rail"
				"magazine safety"
			]
			"youtube" : [
				"https://www.youtube.com/embed/mYDYE9kynbI"
				"https://www.youtube.com/embed/1XVrBv7ldOs"
			]
		}
		{
			"id" : "ruger-sr40c"
			"manufacturer" : "Ruger"
			"name" : "SR40c"
			"description" : "The compact version of the SR40, with near-identical dimensions to their 9mm compact, the SR9c. Slide available either in stainless steel or with a black nitride finish. Also ships with a full-size 15-round magazine and slip-on grip extension."
			"image" : "/img/ruger-sr40c.jpg"
			"msrp" : 569
			"link" : "http://ruger.com/products/sr40c/specSheets/3476.html"
			"caliber" : ".40 S&W"
			"frame" : "polymer"
			"trigger" : "striker"
			"capacity" : 10
			"magazine" : "double"
			"dimensions" :
				"barrel" : 3.5
				"overall" : 6.85
				"height" : 4.61
				"width" : 1.27
				"weight" : 23.4
			"options" : [
				"safety"
				"rail"
				"magazine safety"
			]
			"youtube" : [
				"https://www.youtube.com/embed/LNlqwm6_ol8"
				"https://www.youtube.com/embed/ilpj82qwJQY"
				"https://www.youtube.com/embed/mElslmZN9g4"
			]
		}
		{
			"id" : "ruger-sr45"
			"manufacturer" : "Ruger"
			"name" : "SR45"
			"description" : "Ruger's full-size offering in .45. Slide available either in stainless steel or with a black nitride finish"
			"image" : "/img/ruger-sr45.jpg"
			"msrp" : 569
			"link" : "http://ruger.com/products/sr40c/specSheets/3476.html"
			"caliber" : ".45 ACP"
			"frame" : "polymer"
			"trigger" : "striker"
			"capacity" : 10
			"magazine" : "double"
			"dimensions" :
				"barrel" : 4.5
				"overall" : 8.0
				"height" : 5.75
				"width" : 1.27
				"weight" : 30.1
			"options" : [
				"safety"
				"rail"
				"magazine safety"
			]
			"youtube" : [
				"https://www.youtube.com/embed/R4LVmk1rPNw"
				"https://www.youtube.com/embed/YsFr8ZFSQOw"
				"https://www.youtube.com/embed/BoqIJr0V3mw"
			]
		}
		{
			"id" : "ruger-american-9"
			"manufacturer" : "Ruger"
			"name" : "American"
			"subname" : "9mm"
			"description" : "Part of Ruger's new line of full-size handgun aimed at the military market. Also available in .45 ACP."
			"image" : "/img/ruger-american-9.jpg"
			"msrp" : 569
			"link" : "http://ruger.com/products/rugerAmericanPistol/specSheets/8605.html"
			"caliber" : "9mm"
			"frame" : "polymer"
			"trigger" : "striker"
			"capacity" : 17
			"magazine" : "double"
			"dimensions" :
				"barrel" : 4.2
				"overall" : 7.5
				"height" : 5.6
				"width" : 1.4
				"weight" : 30.0
			"options" : [
				"rail"
			]
			"youtube" : [
				"https://www.youtube.com/embed/FEGqYYgSljE"
			]
		}
		{
			"id" : "ruger-american-45"
			"manufacturer" : "Ruger"
			"name" : "American"
			"subname" : ".45"
			"description" : "Part of Ruger's new line of full-size handgun aimed at the military market. Also available in 9mm."
			"image" : "/img/ruger-american-45.jpg"
			"msrp" : 579
			"link" : "http://ruger.com/products/rugerAmericanPistol/specSheets/8615.html"
			"caliber" : ".45 ACP"
			"frame" : "polymer"
			"trigger" : "striker"
			"capacity" : 10
			"magazine" : "double"
			"dimensions" :
				"barrel" : 4.5
				"overall" : 8.0
				"height" : 5.7
				"width" : 1.4
				"weight" : 31.5
			"options" : [
				"rail"
			]
			"youtube" : [
				"https://www.youtube.com/embed/NKUAxAc6NWk"
			]
		}
		{
			"id" : "ruger-sr1911standard"
			"manufacturer" : "Ruger"
			"name" : "SR1911"
			"subname" : "Standard"
			"description" : "Ruger's take on the classic 1911, available in standard size, a mid-size \"Commander\" model, and a \"lightweight\" version."
			"image" : "/img/ruger-sr1911standard.jpg"
			"msrp" : 939
			"link" : "http://ruger.com/products/sr1911/specSheets/6700.html"
			"caliber" : ".45 ACP"
			"frame" : "steel"
			"trigger" : "hammer SA"
			"capacity" : 8
			"magazine" : "single"
			"dimensions" :
				"barrel" : 5.0
				"overall" : 8.67
				"height" : 5.45
				"width" : 1.34
				"weight" : 39.0
			"options" : [
				"safety"
				"grip safety"
			]
			"youtube" : [
				"https://www.youtube.com/embed/CAZ5EYxpl2o"
			]
		}
		{
			"id" : "ruger-sr1911commander"
			"variant" : "ruger-sr1911standard"
			"subname" : "Commander"
			"image" : "/img/ruger-sr1911commander.jpg"
			"link" : "http://ruger.com/products/sr1911/specSheets/6702.html"
			"capacity" : 7
			"dimensions" : {
				"barrel" : 4.25
				"overall" : 8.67
				"height" : 5.45
				"width" : 1.34
				"weight" : 36.4
			}
		}
		{
			"id" : "ruger-sr1911lightweight"
			"variant" : "ruger-sr1911commander"
			"description" : "Ruger's 1911, in the \"Commander\" size but with an anodized aluminum frame instead of stainless steel."
			"image" : "/img/ruger-sr1911lightweight.jpg"
			"subname" : "Lightweight"
			"msrp" : 979
			"link" : "http://ruger.com/products/sr1911/specSheets/6711.html"
		}
		{
			"id" : "ruger-sr22"
			"manufacturer" : "Ruger"
			"name" : "SR22"
			"description" : "The .22-caliber variant in Ruger's long-standing SR line. The slide is aluminum, not steel. Also available with a threaded barrel."
			"image" : "/img/ruger-sr22.jpg"
			"msrp" : 439
			"link" : "http://ruger.com/products/sr22Pistol/specSheets/3600.html"
			"caliber" : ".22 LR"
			"frame" : "polymer"
			"trigger" : "hammer SA/DA"
			"capacity" : 10
			"magazine" : "single"
			"dimensions" :
				"barrel" : 3.5
				"overall" : 6.4
				"height" : 4.9
				"width" : 0.97
				"weight" : 17.5
			"options" : [
				"safety"
				"rail"
				"decocker"
			]
			"youtube" : [
				"https://www.youtube.com/embed/FWNRG7xBPPk"
			]
		}
		{
			"id" : "ruger-sr22threaded"
			"variant" : "ruger-sr22threaded"
			"description" : "The .22-caliber variant in Ruger's long-standing SR line. The slide is aluminum, not steel."
			"options" : [
				"safety"
				"rail"
				"decocker"
				"threaded"
			]
		}
		{
			"id" : "glock-43"
			"manufacturer" : "Glock"
			"name" : "43"
			"description" : "Anchor of the \"slimline\" series, the long-awaited single-stack Glock in 9."
			"image" : "/img/glock-43.png"
			"link" : "https://us.glock.com/products/model/g43"
			"caliber" : "9mm"
			"frame" : "polymer"
			"trigger" : "striker"
			"capacity" : 6
			"magazine" : "single"
			"dimensions" :
				"barrel" : 3.39
				"overall" : 6.26
				"height" : 4.25
				"width" : 1.02
				"weight" : 17.95
			"options" : [
				"trigger"
				"firing pin"
				"drop"
			]
			"youtube" : [
				"https://www.youtube.com/embed/c5BznRK2dRA"
				"https://www.youtube.com/embed/H6CVf1TKZyE"
				"https://www.youtube.com/embed/8pHdg4F15aQ"
			]
		}
		{
			"id" : "glock-42"
			"manufacturer" : "Glock"
			"name" : "42"
			"description" : "The first single-stack Glock released in the 2010s, and the only .380 currently in the consumer lineup."
			"image" : "/img/glock-42.png"
			"link" : "https://us.glock.com/products/model/g42"
			"caliber" : ".380 ACP"
			"frame" : "polymer"
			"trigger" : "striker"
			"capacity" : 6
			"magazine" : "single"
			"dimensions" :
				"barrel" : 3.25
				"overall" : 5.94
				"height" : 4.13
				"width" : 0.94
				"weight" : 13.76
			"options" : [
				"trigger"
				"firing pin"
				"drop"
			]
			"youtube" : [
				"https://www.youtube.com/embed/TevjYfFe49s"
				"https://www.youtube.com/embed/LskihWv3ALw"
				"https://www.youtube.com/embed/_ZOkPAET86c"
			]
		}
		{
			"id" : "glock-36"
			"manufacturer" : "Glock"
			"name" : "36"
			"description" : "The original \"slimline\" Glock, in .45."
			"image" : "/img/glock-36.png"
			"link" : "https://us.glock.com/products/model/g36"
			"caliber" : ".45 ACP"
			"frame" : "polymer"
			"trigger" : "striker"
			"capacity" : 6
			"magazine" : "single"
			"dimensions" :
				"barrel" : 3.77
				"overall" : 6.96
				"height" : 4.76
				"width" : 1.10
				"weight" : 22.42
			"options" : [
				"trigger"
				"firing pin"
				"drop"
			]
			"youtube" : [
				"https://www.youtube.com/embed/6dW9fu8kmZI"
				"https://www.youtube.com/embed/hLCtDtaWSnw"
				"https://www.youtube.com/embed/7O-GHoHqqsM"
				"https://www.youtube.com/embed/qprvXMVGqGw"
				"https://www.youtube.com/embed/bYJgIFQIAy4"
			]
		}
		{
			"id" : "glock-34"
			"manufacturer" : "Glock"
			"name" : "34"
			"description" : "The longer, competition-minded sibling of the classic Glock 17 in 9mm, with near-identical dimensions to the .40-caliber Glock 35."
			"image" : "/img/glock-34.png"
			"link" : "https://us.glock.com/products/model/g34gen4"
			"caliber" : "9mm"
			"frame" : "polymer"
			"trigger" : "striker"
			"capacity" : 17
			"magazine" : "double"
			"dimensions" :
				"barrel" : 5.31
				"overall" : 8.74
				"height" : 5.43
				"width" : 1.18
				"weight" : 25.95
			"options" : [
				"trigger"
				"firing pin"
				"drop"
				"rail"
			]
			"youtube" : [
				"https://www.youtube.com/embed/BTJfnuhKBc4"
				"https://www.youtube.com/embed/unh_RoCkjz8"
				"https://www.youtube.com/embed/gPW-sfPWzOo"
			]
		}
		{
			"id" : "glock-35"
			"manufacturer" : "Glock"
			"name" : "35"
			"description" : "The longer, competition-minded sibling of the Glock 22 in .40, with near-identical dimensions to the 9mm Glock 34."
			"image" : "/img/glock-35.png"
			"link" : "https://us.glock.com/products/model/g35gen4"
			"caliber" : ".40 S&W"
			"frame" : "polymer"
			"trigger" : "striker"
			"capacity" : 15
			"magazine" : "double"
			"dimensions" :
				"barrel" : 5.31
				"overall" : 8.74
				"height" : 5.43
				"width" : 1.18
				"weight" : 27.53
			"options" : [
				"trigger"
				"firing pin"
				"drop"
				"rail"
			]
			"youtube" : [
				"https://www.youtube.com/embed/jTSAKHPRrl0"
				"https://www.youtube.com/embed/oiBpg71Bul8"
				"https://www.youtube.com/embed/fwNiTLk91X4"
				"https://www.youtube.com/embed/vrnnwlJ2vT8"
			]
		}
		{
			"id" : "glock-41"
			"manufacturer" : "Glock"
			"name" : "41"
			"description" : "The longer, competition-minded sibling of the Glock 20 in .45."
			"image" : "/img/glock-41.png"
			"link" : "https://us.glock.com/products/model/g41gen4"
			"caliber" : ".45 ACP"
			"frame" : "polymer"
			"trigger" : "striker"
			"capacity" : 13
			"magazine" : "double"
			"dimensions" :
				"barrel" : 5.31
				"overall" : 8.80
				"height" : 5.47
				"width" : 1.28
				"weight" : 27.0
			"options" : [
				"trigger"
				"firing pin"
				"drop"
				"rail"
			]
			"youtube" : [
				"https://www.youtube.com/embed/eStUpDS-8wc"
				"https://www.youtube.com/embed/95YAUBUK4rA"
				"https://www.youtube.com/embed/dbqovRFSjV0"
			]
		}
		{
			"id" : "glock-17L"
			"manufacturer" : "Glock"
			"name" : "17L"
			"variant" : "Glock17-4"
			"description" : "The \"long-slide\" version of the Glock 17, with a lighter trigger and adjustable rear sights. Discontinued in favor of the Glock 34."
			"image" : "/img/glock-17L.png"
			"link" : "https://us.glock.com/products/model/g17l"
			"dimensions" :
				"barrel" : 6.02
				"overall" : 9.57
				"height" : 5.43
				"width" : 1.18
				"weight" : 23.63
			"options" : [
				"trigger"
				"firing pin"
				"drop"
				"rail"
			]
			"youtube" : [
				"https://www.youtube.com/embed/UYuPEfPb_wc"
				"https://www.youtube.com/embed/tHTBPEtrDO8"
				"https://www.youtube.com/embed/OPp0N1wtz10"
			]
			"amazon" : [
			]
		}
		{
			"id" : "glock-24"
			"manufacturer" : "Glock"
			"name" : "24"
			"description" : "Glock's first competition gun, the discontinued version of the Glock 35 in .40."
			"image" : "/img/glock-24.png"
			"link" : "https://us.glock.com/products/model/g24"
			"caliber" : ".40 S&W"
			"frame" : "polymer"
			"trigger" : "striker"
			"capacity" : 15
			"magazine" : "double"
			"dimensions" :
				"barrel" : 6.02
				"height" : 5.43
				"overall" : 8.83
				"width" : 1.18
				"weight" : 26.7
			"options" : [
				"trigger"
				"firing pin"
				"drop"
				"rail"
			]
			"youtube" : [
				"https://www.youtube.com/embed/vCwT7K7sPKQ"
				"https://www.youtube.com/embed/dd848bus9aE"
			]
		}
			{
				"id" : "glock-40"
				"manufacturer" : "Glock"
				"name" : "40"
				"description" : "Glock's 10mm competition gun."
				"image" : "/img/glock-40.png"
				"link" : "https://us.glock.com/products/model/g40gen4mos"
				"caliber" : "10mm"
				"frame" : "polymer"
				"trigger" : "striker"
				"capacity" : 15
				"magazine" : "double"
				"dimensions" :
					"barrel" : 6.02
					"height" : 5.47
					"overall" : 9.49
					"width" : 1.28
					"weight" : 28.15
				"options" : [
					"trigger"
					"firing pin"
					"drop"
					"rail"
				]
				"youtube" : [
					"https://www.youtube.com/embed/lwGrpePCYeI"
					"https://www.youtube.com/embed/0LUJZ1qWUrM"
					"https://www.youtube.com/embed/Lvt2pxSGABg"
				]
			}
	]

	# massage the datas:
	for gun in gunList
		# copy in the data from variant guns:
		if gun.variant
			baseIndex = _.findIndex gunList, {"id" : gun.variant}
			if baseIndex == -1
				console.log("WARN: Variant of gun " + gun.id + " doesn't exist.")
				return
			base = gunList[baseIndex]
			baseProperties = _.keysIn(base)

			for prop in baseProperties
				 gun[prop] = base[prop] if !gun[prop]

		# format youtube embeds:
		if gun.youtube
			gun.embed = []
			for video in gun.youtube
				gun.embed.push $sce.trustAsHtml '<iframe width="560" height="315" src="' + video + '" frameborder="0" allowfullscreen></iframe>'

		# format amazon product embeds:
		if gun.amazon
			gun.amazonEmbeds = [];
			for product in gun.amazon
				gun.amazonEmbeds.push $sce.trustAsHtml '<iframe style="width:120px;height:240px;" marginwidth="0" marginheight="0" scrolling="no" frameborder="0" src="' + product + '"></iframe>'

		# fill in the display names of the gun's options:
		gun.printOptions = [];
		if gun.options
			for option in gun.options
				lookup = _.find PRINTING.options, {"name" : option}
				if lookup?
					gun.printOptions.push lookup.display
				else
					gun.printOptions.push option	# if there isn't a print name specified, just send it through

		# **Variants and families:
		# find the families that include the current gun:
		zzz = _.filter FAMILIES, (f) ->
			return _.includes(f.members, gun.id)

		gun.families = _.cloneDeep zzz
		for family, findex in gun.families
			# translate gun IDs into actual gun data, replace the IDs:
			for member, mindex in family.members
				gun.families[findex].members[mindex] = _.find gunList, {"id" : member}

		# if it's a variant, search for its siblings, otherwise search for its children
		variants =
			"name" : "Variants"
			"members" : _.filter gunList, { 'variant': gun.variant || gun.id }

		# if it's a variant, add its parent:
		if gun.variant then variants.members.push _.find gunList, { 'id': gun.variant }

		# add the variants (if there are any) to the main list of families:
		if variants.members.length > 0 then gun.families.push variants

	return gunList;
]

app.factory 'FAMILIES', ->
	return [
		{
			"name" : "9mm Glocks"
			"members" : [
				"Glock17-4"
				"Glock19-4"
				"Glock26-4"
			]
		}
		{
			"name" : ".40 Glocks"
			"members" : [
				"Glock22-4"
				"Glock23-4"
				"Glock27-4"
			]
		}
		{
			"name" : "10mm Glocks"
			"members" : [
				"Glock20-4"
				"Glock29-4"
			]
		}
		{
			"name" : ".45 Glocks"
			"members" : [
				"Glock21-4"
				"Glock30-4"
			]
		}
		{
			"name" : ".45 GAP Glocks"
			"members" : [
				"Glock37-4"
				"Glock38"
				"Glock39"
			]
		}
	]

app.factory 'WIZARD', ->
	self =
		caliberPrompts: [
			{
				"name" : ".22LR"
				"description" : "The <strong>.22 Long Rifle</strong> cartridge, also known simply as the \".22.\" The smallest of the bunch and the only rimfire cartridge on the list &ndash; most modern pistols use \"centerfire\" cartridges, which position the explosive primer in the center of the rear of the cartridge instead of around the edges. A popular \"plinking\" ammo because it's cheap, (usually) easy to find, and has minimal noise and recoil. Potentially useful for varmint shooting, but doesn't commonly come up in conversations about concealed carry."
			}
			{
				"name" : ".380 ACP"
				"description" : "The <strong>.380 ACP</strong> cartridge, among the first modern \"pocket pistol\" calibers, is considered on the borderline of effectiveness for concealed carry &ndash; which side of that border it's on depends on whom you ask. Essentially a shorter 9mm round, .380 ACP fires lighter bullets at lower velocities, which reduces the physical requirements of handguns chambered to fire it. As a result, it's a popular choice for those who require deep concealment or a \"BUG\" (back-up gun) to go along with their primary carry gun."
			}
			{
				"name" : "9mm"
				"description" : "Refers specifically to the <strong>9x19 mm Parabellum</strong> round, also known as <a href='https://en.wikipedia.org/wiki/9%C3%9719mm_Parabellum'>9mm Luger</a> or, more commonly, just \"9mm.\" The standard-issue sidearm of the U.S. Army for the past 30 years <a href='http://www.military.com/daily-news/2014/07/03/army-wants-a-harder-hitting-pistol.html'>(but possibly not forever)</a> and a popular choice for concealed carry because it has <a href='http://www.luckygunner.com/labs/self-defense-ammo-ballistic-tests/'>better performance</a> than smaller cartridges but doesn't require the weight and bulk of large cartridges like the .45 ACP."
			}
			{
				"name" : ".40 S\&W"
				"description" : "A lower-recoil variant of the 10mm cartridge, developed by Smith \& Wesson for the Federal Bureau of Investigations. While most popular handgun cartridges were developed in the first half of the 20th century, the .40 S\&W didn't appear on the scene until almost 1990, but has grown in popularity from a practical law enforcement caliber with enhanced stopping power into a commonly chosen consumer option offered by most large weapons manufacturers. <p>The increased power allows .40 rounds to propel rounds heavier than the 9mm at almost identical speeds, at the predictable cost of reduced magazine capacity and slightly larger slides."
			}
			{
				"name" : ".45 ACP"
				"description" : "A heavier bullet, fired at lower velocities. The famed M1911 designed by John Browning is chambered in .45 and was the standard-issue sidearm of the U.S. Army through two world wars and the majority of the 20th century. Its increased diameter is usually associated either with reduced magazine capacity or grip sizes notably larger than smaller-caliber handguns."
			}
		]
		framePrompts: [
			{
				"name" : "steel"
				"description" : "The traditional material for constructing modern handguns, but also the heaviest. Those considering concealed carry may want to investigate aluminum or polymer frames, for reduced weight without reduced firepower. The extra heft, however, can be helpful otherwise: In addition to increased toughness, weighty steel frames can help absorb the recoil of the bigger calibers that might otherwise be less manageable."
			}
			{
				"name" : "polymer"
				"description" : "The revolution led by Glock and its space-age plastics changed the face of pistols the world over: Though almost all handguns still have steel slides, polymer frames are markedly lighter than their metallic counterparts. For example: A full-size .45-caliber 1911 could weigh in at about 44 ounces, while a Smith & Wesson M&P in the same caliber (but with a polymer frame) weighs 27.7 ounces – 37 percent lighter."
			}
			{
				"name" : "aluminum alloy"
				"description" : "The \"middle ground\" between the dense steel alloys and the polymers. The steel versus aluminum debate is had more often in discussions about revolvers, but Beretta and CZ offer well-respected guns built using it."
			}
		]
		triggerPrompts: [
			{
				"name" : "hammer SA/DA"
				"description" : "\"SA/DA\" is short for \"single-action/double-action,\" which refers to the number of actions the trigger will take with one pull: \"Double action\" means the trigger can perform two acts: First, it pulls the hammer back, cocking the weapon. Then, it releases the hammer, sending it forward quickly and firing the round. \"Single action\" is only the second half of that: Pulling the trigger releases the trigger and sends it forward to fire the gun, but it needs to have been cocked by some other mechanism, such as your finger.<p>\"SA/DA\" means the gun can operate in either mode: If the gun is not cocked, pulling the trigger gives you the double-action pull that does both actions. If you want a \"single-action trigger pull,\" – almost invariably shorter and easier than a double-action one – you can cock the hammer back by hand.<p>There is another way to get the single-action pull, too: On semi-automatic SA/DA guns, firing the gun causes the slide to \"cycle,\" which does several things: It will eject the spent case and load the next round into the chamber, but it also cocks the hammer on its way rearward. This means that even if your first trigger pull is double-action, all subsequent pulls will be single action. This benefit is sometimes cited as a negative, however, because it requires users train on two different \"pulls,\" essentially turning the act of pulling the trigger into two very different acts."
			}
			{
				"name" : "hammer SA"
				"description" : "A single-action handgun is one that requires the hammer be cocked before the trigger will do anything – if the hammer is down, the trigger won't pull it backwards, so you need to either rack the slide or pull the trigger back manually. In modern handguns, the single-action trigger mechanism is usually only seen on the more faithful reproductions of the classic G.I. \"1911\" design, carried by the U.S. military for 75 years."
			}
			{
				"name" : "hammer SA"
				"description" : "A single-action handgun is one that requires the hammer be cocked before the trigger will do anything – if the hammer is down, the trigger won't pull it backwards, so you need to either rack the slide or pull the trigger back manually. In modern handguns, the single-action trigger mechanism is usually only seen on the more faithful reproductions of the classic G.I. \"1911\" design, carried by the U.S. military for 75 years."
			}
			{
				"name" : "striker"
				"description" : "Striker-fired handguns are the most modern variant commonly sold on the market – they do away with the hammer altogether, instead driving the firing pin into the round using a spring-loaded piston. Almost all polymer handguns use a striker, and the ones that don't have internal hammers."
			}
		]
		featurePrompts: [
			{
				"name" : "Front accessory rail"
				"description" : "A small rail molded into the front of the gun, under the barrel. Used to attach accessories such as flashlights or lasers."
			}
			{
				"name" : "Decocker"
				"description" : "Occasionally installed in place of a safety on hammer-fired handguns, it provides a way to safely lower the hammer from a cocked position without pulling the trigger to release it. Some say its presence negatively affects trigger pull."
			}
			{
				"name" : "Threaded barrel"
				"description" : "An extended barrel that sticks out a short distance in front of the slide, used mostly as a socket for a suppressor."
			}
			{
				"name" : "Thumb safety"
				"description" : "The traditional \"safety\" that people think of when they hear one referred to. Either on the left side or both sides, it's designed to be articulated by the thumb and disable the trigger when engaged. Some oppose their use, specifically on carry weapons, because they add a point of failure and open the carrier to the risk of forgetting to disengage it before firing."
			}
			{
				"name" : "Grip safety"
				"description" : "Another vestige of the 1911 design. Effectively a small metal or plastic pad on the back of the gun's grip, pushed in by the user's hand when they are holding the pistol in a firing grip. Not commonly included on modern designs."
			}
		]

	return self;
