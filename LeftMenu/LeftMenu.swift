//
//  LeftMenu.swift
//  Fiind
//
//  Created by İlyas Abiyev on 6/9/20.
//  Copyright © 2020 İlyas Abiyev. All rights reserved.
//

import UIKit
import Firebase
import CoreLocation
import MapKit
import CoreData


extension LeftMenu : UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if touch.view?.isDescendant(of: self.tableVIew) == true {
            return false
        }  else {
            view.endEditing(true)
            return true
        }
    }
}


class LeftMenu: UIViewController,MKMapViewDelegate,CLLocationManagerDelegate {
    
    @IBOutlet weak var tableVIew: UITableView!
    
    var mapView = MKMapView()
    
    var locationManager = CLLocationManager()
    
    var locationcontrol = false
    
    var lattitude = Double()
    var longitude = Double()
    
    
    
    
    let visualEffectView : UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .dark)
        let view = UIVisualEffectView(effect: blurEffect)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    let btnTurkey : UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(named: "turkey"), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(turkeyAction), for: .touchUpInside)
        return btn
    }()
    
    let btnGermany : UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(named: "germany"), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(germanyAction), for: .touchUpInside)
        return btn
    }()
    
    let btnUk : UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(named: "uk"), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(ukAction), for: .touchUpInside)
        return btn
    }()
    
    let btnAlgeri : UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(named: "algeria"), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(algeriAction), for: .touchUpInside)
        return btn
    }()
    
    let btnRussia : UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(named: "russia"), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(russiaAction), for: .touchUpInside)
        return btn
    }()
    
    let btnDenmark : UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(named: "denmark"), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(denmarkAction), for: .touchUpInside)
        return btn
    }()
    
    let btnFrench : UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(named: "french"), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(frenchAction), for: .touchUpInside)
        return btn
    }()
    
    let btnItaly : UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(named: "italy"), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(italyAction), for: .touchUpInside)
        return btn
    }()
    
    let btnHolland : UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(named: "holland"), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(hollandAction), for: .touchUpInside)
        return btn
    }()
    
    let lineView1 : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.heightAnchor.constraint(equalToConstant: 70).isActive = true
        view.widthAnchor.constraint(equalToConstant: 2).isActive = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let lineView2 : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.heightAnchor.constraint(equalToConstant: 70).isActive = true
        view.widthAnchor.constraint(equalToConstant: 2).isActive = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let lineView3 : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.heightAnchor.constraint(equalToConstant: 70).isActive = true
        view.widthAnchor.constraint(equalToConstant: 2).isActive = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let lineView4 : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.heightAnchor.constraint(equalToConstant: 70).isActive = true
        view.widthAnchor.constraint(equalToConstant: 2).isActive = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let lineView5 : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.heightAnchor.constraint(equalToConstant: 70).isActive = true
        view.widthAnchor.constraint(equalToConstant: 2).isActive = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let lineView6 : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.heightAnchor.constraint(equalToConstant: 70).isActive = true
        view.widthAnchor.constraint(equalToConstant: 2).isActive = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let stackView = UIStackView()
    
    let stackView2 = UIStackView()
    
    let stackView3 = UIStackView()
    
    let lblHesap : UILabel = {
        let hesap = UILabel()
        hesap.text = "Hesap"
        return hesap
    }()
    
    let lblAnaSayfa : UILabel = {
        let hesap = UILabel()
        hesap.text = "AnaSayfa"
        return hesap
    }()
    
    let lblKonumunuGuncelle : UILabel = {
        let hesap = UILabel()
        hesap.text = "Konumu Güncelle"
        return hesap
    }()
    
    let lblDiliDegistir : UILabel = {
        let hesap = UILabel()
        hesap.text = "Dili değiştir"
        return hesap
    }()
    
    let lblCikisYap : UILabel = {
        let hesap = UILabel()
        hesap.text = "Çıkış Yap"
        return hesap
    }()
    
    let lblKategoriler : UILabel = {
        let hesap = UILabel()
        hesap.text = "Kategoriler"
        return hesap
    }()
    
    let lblAvukat : UILabel = {
        let hesap = UILabel()
        hesap.text = "Avukat"
        return hesap
    }()
    
    let lblArabaTamir : UILabel = {
        let hesap = UILabel()
        hesap.text = "Araba Tamir"
        return hesap
    }()
    
    let lblArabaParca : UILabel = {
        let hesap = UILabel()
        hesap.text = "Araba parça"
        return hesap
    }()
    let lblAv : UILabel = {
        let hesap = UILabel()
        hesap.text = "Av Malzemesi"
        return hesap
    }()
    let lblBanka : UILabel = {
        let hesap = UILabel()
        hesap.text = "Banka"
        return hesap
    }()
    let lblBankamatik : UILabel = {
        let hesap = UILabel()
        hesap.text = "Bankamatik"
        return hesap
    }()
    let lblBelediye : UILabel = {
        let hesap = UILabel()
        hesap.text = "Belediye"
        return hesap
    }()
    let lblBerber : UILabel = {
        let hesap = UILabel()
        hesap.text = "Berber"
        return hesap
    }()
    let lblBenzinlik : UILabel = {
        let hesap = UILabel()
        hesap.text = "Benzinlik"
        return hesap
    }()
    
    let lblBilgisayar : UILabel = {
        let hesap = UILabel()
        hesap.text = "Bilgisayar"
        return hesap
    }()
    
    let lblBisiklet : UILabel = {
        let hesap = UILabel()
        hesap.text = "Bisiklet"
        return hesap
    }()
    
    let lblBeyazEsya : UILabel = {
        let hesap = UILabel()
        hesap.text = "Beyaz Eşya"
        return hesap
    }()
    
    let lblCafe : UILabel = {
        let hesap = UILabel()
        hesap.text = "Cafe"
        return hesap
    }()
    
    let lblCepTelefonu : UILabel = {
        let hesap = UILabel()
        hesap.text = "Cep Telefonu"
        return hesap
    }()
    
    let lblCicekci : UILabel = {
        let hesap = UILabel()
        hesap.text = "Çiçekci"
        return hesap
    }()
    
    let lblCocukParki : UILabel = {
        let hesap = UILabel()
        hesap.text = "Çoçuk Parkı"
        return hesap
    }()
    let lblDershane : UILabel = {
        let hesap = UILabel()
        hesap.text = "Dershane"
        return hesap
    }()
    
    let lblDugun : UILabel = {
        let hesap = UILabel()
        hesap.text = "Düğün"
        return hesap
    }()
    
    let lblEczane : UILabel = {
        let hesap = UILabel()
        hesap.text = "Eczane"
        return hesap
    }()
    
    let lblEglence : UILabel = {
        let hesap = UILabel()
        hesap.text = "Eğlence"
        return hesap
    }()
    
    let lblEhliytet : UILabel = {
        let hesap = UILabel()
        hesap.text = "Ehliyet"
        return hesap
    }()
    
    let lblElektronik : UILabel = {
        let hesap = UILabel()
        hesap.text = "Elektronik"
        return hesap
    }()
    
    let lblFabrika : UILabel = {
        let hesap = UILabel()
        hesap.text = "Fabrika"
        return hesap
    }()
    
    let lblFirin : UILabel = {
        let hesap = UILabel()
        hesap.text = "Fırın"
        return hesap
    }()
    
    let lblHastane : UILabel = {
        let hesap = UILabel()
        hesap.text = "Hastane"
        return hesap
    }()
    
    let lblHamam : UILabel = {
        let hesap = UILabel()
        hesap.text = "Hamam"
        return hesap
    }()
    
    let lblGiyim : UILabel = {
        let hesap = UILabel()
        hesap.text = "Giyim"
        return hesap
    }()
    
    let lblGuzellikSalonu : UILabel = {
        let hesap = UILabel()
        hesap.text = "Güzellik Salonu"
        return hesap
    }()
    
    let lblKasap : UILabel = {
        let hesap = UILabel()
        hesap.text = "Kasap"
        return hesap
    }()
    
    let lblKirtasiye : UILabel = {
        let hesap = UILabel()
        hesap.text = "Kırtasiye"
        return hesap
    }()
    
    let lblKres : UILabel = {
        let hesap = UILabel()
        hesap.text = "Kreş"
        return hesap
    }()
    
    let lblKonsulluk : UILabel = {
        let hesap = UILabel()
        hesap.text = "Konsolosluk"
        return hesap
    }()
    
    let lblKozmetik : UILabel = {
        let hesap = UILabel()
        hesap.text = "Kozmetik"
        return hesap
    }()
    
    let lblKursYerleri : UILabel = {
        let hesap = UILabel()
        hesap.text = "Kurs Yerleri"
        return hesap
    }()
    
    let lblKuruTemizleme : UILabel = {
        let hesap = UILabel()
        hesap.text = "KuruTemizleme"
        return hesap
    }()
    
    let lblKucukIlan : UILabel = {
        let hesap = UILabel()
        hesap.text = "Küçük İlan"
        return hesap
    }()
    
    let lblLokanta : UILabel = {
        let hesap = UILabel()
        hesap.text = "Lokanta"
        return hesap
    }()
    
    let lblmanav : UILabel = {
        let hesap = UILabel()
        hesap.text = "Manav"
        return hesap
    }()
    
    let lblMasaj : UILabel = {
        let hesap = UILabel()
        hesap.text = "Masaj"
        return hesap
    }()
    
    let lblMarangoz : UILabel = {
        let hesap = UILabel()
        hesap.text = "marangoz"
        return hesap
    }()
    
    let lblMarket : UILabel = {
        let hesap = UILabel()
        hesap.text = "Market"
        return hesap
    }()
    
    let lblMobilya : UILabel = {
        let hesap = UILabel()
        hesap.text = "Mobilya"
        return hesap
    }()
    
    let lblMuzik : UILabel = {
        let hesap = UILabel()
        hesap.text = "Müzik"
        return hesap
    }()
    
    let lblNufus : UILabel = {
        let hesap = UILabel()
        hesap.text = "Nüfus"
        return hesap
    }()
    
    let lblOkul : UILabel = {
        let hesap = UILabel()
        hesap.text = "Okul"
        return hesap
    }()
    
    let lblOtel : UILabel = {
        let hesap = UILabel()
        hesap.text = "Otel"
        return hesap
    }()
    
    let lblotoPark : UILabel = {
        let hesap = UILabel()
        hesap.text = "Otopark"
        return hesap
    }()
    
    let lblOrganizasyon : UILabel = {
        let hesap = UILabel()
        hesap.text = "Organizasyon"
        return hesap
    }()
    
    let lblOzelOkul : UILabel = {
        let hesap = UILabel()
        hesap.text = "Özel Okul"
        return hesap
    }()
    
    let lblPastane : UILabel = {
        let hesap = UILabel()
        hesap.text = "Pastane"
        return hesap
    }()
    
    let lblPolisOkulu : UILabel = {
        let hesap = UILabel()
        hesap.text = "Polis Okulu"
        return hesap
    }()
    
    let lblPtt : UILabel = {
        let hesap = UILabel()
        hesap.text = "Ptt"
        return hesap
    }()
    
    let lblRestoren : UILabel = {
        let hesap = UILabel()
        hesap.text = "Restoran"
        return hesap
    }()
    
    let lblSarraf : UILabel = {
        let hesap = UILabel()
        hesap.text = "Sarraf"
        return hesap
    }()
    
    let lblSerbestMeslek : UILabel = {
        let hesap = UILabel()
        hesap.text = "Serbest Meslek"
        return hesap
    }()
    
    let lblSinema : UILabel = {
        let hesap = UILabel()
        hesap.text = "Sinema"
        return hesap
    }()
    
    let lblSigorta : UILabel = {
        let hesap = UILabel()
        hesap.text = "Sigorta"
        return hesap
    }()
    
    let lblSpor : UILabel = {
        let hesap = UILabel()
        hesap.text = "Spor"
        return hesap
    }()
    
    let lblTatilYeri : UILabel = {
        let hesap = UILabel()
        hesap.text = "Tatiş Yeri"
        return hesap
    }()
    
    let lblTemizlik : UILabel = {
           let hesap = UILabel()
           hesap.text = "Temizlik"
           return hesap
       }()
    
    let lbltercume : UILabel = {
           let hesap = UILabel()
           hesap.text = "Tercüme"
           return hesap
       }()
    
    let lblterzi : UILabel = {
           let hesap = UILabel()
           hesap.text = "Terzi"
           return hesap
       }()
    
    let lblToptanci : UILabel = {
           let hesap = UILabel()
           hesap.text = "Toptancı"
           return hesap
       }()
    
    let lblMuhasabe : UILabel = {
        let hesap = UILabel()
        hesap.text = "Muhasabe"
        return hesap
    }()
    
    let Alert1 : UILabel = {
           let hesap = UILabel()
           hesap.text = "Muhasabe"
           return hesap
       }()
    
    let Alert2 : UILabel = {
           let hesap = UILabel()
           hesap.text = "Çıkıs yapmak istediğinizden eminmisiniz?"
           return hesap
       }()
    
    let Alert3 : UILabel = {
           let hesap = UILabel()
           hesap.text = "Evet"
           return hesap
       }()
    
    let Alert4 : UILabel = {
           let hesap = UILabel()
           hesap.text = "İptal Et"
           return hesap
       }()
    
    let Alert5 : UILabel = {
           let hesap = UILabel()
           hesap.text = "Konum Güncellendi"
           return hesap
       }()
    
    let Alert6 : UILabel = {
           let hesap = UILabel()
           hesap.text = "Tamam"
           return hesap
       }()
    
  
     var country = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        getData()
        
        if country == "tr" {
            actionLanguageLeft_tr()
            print("tr")
        } else if country == "de" {
            actionLanguageLeft_de()
        }else if country == "en" {
            actionLanguageLeft_en()
        }else if country == "ar" {
            actionLanguageLeft_ar()
        }else if country == "ru" {
            actionLanguageLeft_ru()
        }else if country == "da" {
            actionLanguageLeft_da()
        }else if country == "fr" {
            actionLanguageLeft_fr()
        }else if country == "it" {
            actionLanguageLeft_it()
        }else if country == "nl" {
            actionLanguageLeft_nl()
        }
        
        tableVIew.delegate = self
        tableVIew.dataSource = self
        tableVIew.separatorColor = .white
        
        
        mapView.delegate = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        view.addSubview(visualEffectView)
        
        stackView.addArrangedSubview(btnTurkey)
        stackView.addArrangedSubview(lineView1)
        stackView.addArrangedSubview(btnGermany)
        stackView.addArrangedSubview(lineView2)
        stackView.addArrangedSubview(btnUk)
        
        stackView2.addArrangedSubview(btnAlgeri)
        stackView2.addArrangedSubview(lineView3)
        stackView2.addArrangedSubview(btnRussia)
        stackView2.addArrangedSubview(lineView4)
        stackView2.addArrangedSubview(btnDenmark)
        
        stackView3.addArrangedSubview(btnFrench)
        stackView3.addArrangedSubview(lineView5)
        stackView3.addArrangedSubview(btnItaly)
        stackView3.addArrangedSubview(lineView6)
        stackView3.addArrangedSubview(btnHolland)
        
        
        stackView.axis = .horizontal
        stackView.spacing = 10
        
        stackView2.axis = .horizontal
        stackView2.spacing = 10
        
        stackView3.axis = .horizontal
        stackView3.spacing = 10
        
        view.addSubview(stackView)
        view.addSubview(stackView2)
        view.addSubview(stackView3)
        
        
        stackView2.merkezKonumlamdirmaSuperView()
        
        _ = stackView.anchor(top: nil, bottom: stackView2.topAnchor, leading: nil, trailing: nil,padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        stackView.merkezXSuperView()
        
        _ = stackView3.anchor(top: stackView2.bottomAnchor, bottom: nil, leading: nil, trailing: nil,padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        
        stackView3.merkezXSuperView()
        
        visualEffectView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        visualEffectView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        visualEffectView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        visualEffectView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        
        visualEffectView.isHidden = true
        stackView.isHidden = true
        stackView2.isHidden = true
        stackView3.isHidden = true
        
        
        let gesturereRecongizer = UITapGestureRecognizer(target: self, action: #selector(viewHiddenAction))
        gesturereRecongizer.delegate = self
        view.addGestureRecognizer(gesturereRecongizer)
        
        
        
    }
    
    func getData() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Language")
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
            let results =  try context.fetch(fetchRequest)
            
            for result in results as! [NSManagedObject] {
                if let country = result.value(forKey: "country") as? String {
                    //self.countryArray.append(country)
                    self.country = country
                }
            }
            print("request")
        }catch{
            print("error")
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
        lattitude = location.latitude
        longitude = location.latitude
    }
    
    func changeLanguage(str:String)  {
        
        
        lblHesap.text = "Hesap".addLocalizableString(str: str)
        lblAnaSayfa.text = "Ana Sayfa".addLocalizableString(str: str)
        lblKonumunuGuncelle.text = "Konumunu Güncelle".addLocalizableString(str: str)
        lblDiliDegistir.text = "Dili değiştir".addLocalizableString(str: str)
        lblCikisYap.text = "Çıkış Yap".addLocalizableString(str: str)
        lblKategoriler.text = "Kategoriler".addLocalizableString(str: str)
        lblAvukat.text = "Avukat".addLocalizableString(str: str)
        lblArabaParca.text = "Araba Parça".addLocalizableString(str: str)
        lblArabaTamir.text = "Araba Tamir".addLocalizableString(str: str)
        lblAv.text = "Araba Parça".addLocalizableString(str: str)
        lblBanka.text = "Banka".addLocalizableString(str: str)
        lblBankamatik.text = "Bankamatik".addLocalizableString(str: str)
        lblBelediye.text = "Belediye".addLocalizableString(str: str)
        lblBerber.text = "Berber".addLocalizableString(str: str)
        lblBenzinlik.text = "Benzinlik".addLocalizableString(str: str)
        lblBilgisayar.text = "Bilgisayar".addLocalizableString(str: str)
        lblBisiklet.text = "Bisiklet".addLocalizableString(str: str)
        lblBeyazEsya.text = "Beyaz Eşya".addLocalizableString(str: str)
        lblCafe.text = "Cafe".addLocalizableString(str: str)
        lblCepTelefonu.text = "Cep Telefonu".addLocalizableString(str: str)
        lblCicekci.text = "Çiçekçi".addLocalizableString(str: str)
        lblCocukParki.text = "Çocuk Parkı".addLocalizableString(str: str)
        lblDershane.text = "Dershane".addLocalizableString(str: str)
        lblDugun.text = "Düğün".addLocalizableString(str: str)
        lblEczane.text = "Eczane".addLocalizableString(str: str)
        lblEglence.text = "Eğlence".addLocalizableString(str: str)
        lblEhliytet.text = "Ehliyet".addLocalizableString(str: str)
        lblElektronik.text = "Elektronik".addLocalizableString(str: str)
        lblFabrika.text = "Fabrika".addLocalizableString(str: str)
        lblFirin.text = "Fırın".addLocalizableString(str: str)
        lblHastane.text = "Hastane".addLocalizableString(str: str)
        lblHamam.text = "Hamam".addLocalizableString(str: str)
        lblGiyim.text = "Giyim".addLocalizableString(str: str)
        lblGuzellikSalonu.text = "Güzellik Salonu".addLocalizableString(str: str)
        lblKasap.text = "Kasap".addLocalizableString(str: str)
        lblKirtasiye.text = "Kırtasiye".addLocalizableString(str: str)
        lblKres.text = "Kreş".addLocalizableString(str: str)
        lblKonsulluk.text = "Konsolosluk".addLocalizableString(str: str)
        lblKozmetik.text = "Kozmetik".addLocalizableString(str: str)
        lblKursYerleri.text = "Kurs Yerleri".addLocalizableString(str: str)
        lblKuruTemizleme.text = "Kuru Temizleme".addLocalizableString(str: str)
        lblKucukIlan.text = "Küçük İlan".addLocalizableString(str: str)
        lblLokanta.text = "Lokanta".addLocalizableString(str: str)
        lblmanav.text = "Manav".addLocalizableString(str: str)
        lblMasaj.text = "Masaj".addLocalizableString(str: str)
        lblMarangoz.text = "Marangoz".addLocalizableString(str: str)
        lblMarket.text = "Market".addLocalizableString(str: str)
        lblMobilya.text = "Mobilya".addLocalizableString(str: str)
        lblMuhasabe.text = "Muhasebe".addLocalizableString(str: str)
        lblMuzik.text = "Müzik".addLocalizableString(str: str)
        lblNufus.text = "Nüfus".addLocalizableString(str: str)
        lblOkul.text = "Okul".addLocalizableString(str: str)
        lblOtel.text = "Otel".addLocalizableString(str: str)
        lblotoPark.text = "Otopark".addLocalizableString(str: str)
        lblOrganizasyon.text = "Organizasyon".addLocalizableString(str: str)
        lblOzelOkul.text = "Özel Okul".addLocalizableString(str: str)
        lblPastane.text = "Pastane".addLocalizableString(str: str)
        lblPolisOkulu.text = "Polis Karakolu".addLocalizableString(str: str)
        lblPtt.text = "PTT".addLocalizableString(str: str)
        lblRestoren.text = "Restorant".addLocalizableString(str: str)
        lblSarraf.text = "Sarraf".addLocalizableString(str: str)
        lblSerbestMeslek.text = "Serbest Meslek".addLocalizableString(str: str)
        lblSinema.text = "Sinema".addLocalizableString(str: str)
        lblSigorta.text = "Sigorta".addLocalizableString(str: str)
        lblSpor.text = "Spor".addLocalizableString(str: str)
        lblTatilYeri.text = "Tatil Yeri".addLocalizableString(str: str)
        lblTemizlik.text = "Temizlik".addLocalizableString(str: str)
        lbltercume.text = "Tercüme".addLocalizableString(str: str)
        lblterzi.text = "Terzi".addLocalizableString(str: str)
        lblToptanci.text = "Toptancı".addLocalizableString(str: str)
        Alert1.text = "Çıkış Yap".addLocalizableString(str: str)
        Alert2.text = "Çıkıs yapmak istediğinizden eminmisiniz?".addLocalizableString(str: str)
        Alert3.text = "Evet".addLocalizableString(str: str)
        Alert4.text = "İptal Et".addLocalizableString(str: str)
        Alert5.text = "Konum Güncellendi".addLocalizableString(str: str)
        Alert6.text = "Tamam".addLocalizableString(str: str)
        
    
        
        tableVIew.reloadData()
    }
    
    
    
    @objc func viewHiddenAction() {
        visualEffectView.isHidden = true
        stackView.isHidden = true
        stackView2.isHidden = true
        stackView3.isHidden = true
        
    }
    
    
    @objc func turkeyAction() {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let newLanguage = NSEntityDescription.insertNewObject(forEntityName: "Language", into: context)
        
        newLanguage.setValue("tr", forKey: "country")
        
        do {
            try context.save()
            print("save")
        }catch {
            print("erro")
        }
        
        
        let splashView = SplashView()
        splashView.modalPresentationStyle = .fullScreen
        self.present(splashView, animated: true, completion: nil)
        
    }
    
    @objc func germanyAction() {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let newLanguage = NSEntityDescription.insertNewObject(forEntityName: "Language", into: context)
        
        newLanguage.setValue("de", forKey: "country")
        
        do {
            try context.save()
            print("save")
        }catch {
            print("erro")
        }
        
        let splashView = SplashView()
        splashView.modalPresentationStyle = .fullScreen
        self.present(splashView, animated: true, completion: nil)
        
    }
    
    @objc func ukAction() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let newLanguage = NSEntityDescription.insertNewObject(forEntityName: "Language", into: context)
        
        newLanguage.setValue("en", forKey: "country")
        
        do {
            try context.save()
            print("save")
        }catch {
            print("erro")
        }
        
        let splashView = SplashView()
        splashView.modalPresentationStyle = .fullScreen
        self.present(splashView, animated: true, completion: nil)
    }
    
    @objc func algeriAction() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let newLanguage = NSEntityDescription.insertNewObject(forEntityName: "Language", into: context)
        
        newLanguage.setValue("ar", forKey: "country")
        
        do {
            try context.save()
            print("save")
        }catch {
            print("erro")
        }
        
        
        let splashView = SplashView()
        splashView.modalPresentationStyle = .fullScreen
        self.present(splashView, animated: true, completion: nil)
    }
    
    @objc func russiaAction() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let newLanguage = NSEntityDescription.insertNewObject(forEntityName: "Language", into: context)
        
        newLanguage.setValue("ru", forKey: "country")
        
        do {
            try context.save()
            print("save")
        }catch {
            print("erro")
        }
        
        
        let splashView = SplashView()
        splashView.modalPresentationStyle = .fullScreen
        self.present(splashView, animated: true, completion: nil)
    }
    
    @objc func denmarkAction() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let newLanguage = NSEntityDescription.insertNewObject(forEntityName: "Language", into: context)
        
        newLanguage.setValue("da", forKey: "country")
        
        do {
            try context.save()
            print("save")
        }catch {
            print("erro")
        }
        
        
        let splashView = SplashView()
        splashView.modalPresentationStyle = .fullScreen
        self.present(splashView, animated: true, completion: nil)
    }
    
    @objc func frenchAction() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let newLanguage = NSEntityDescription.insertNewObject(forEntityName: "Language", into: context)
        
        newLanguage.setValue("fr", forKey: "country")
        
        do {
            try context.save()
            print("save")
        }catch {
            print("erro")
        }
        
        
        let splashView = SplashView()
        splashView.modalPresentationStyle = .fullScreen
        self.present(splashView, animated: true, completion: nil)
    }
    
    @objc func italyAction() {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let newLanguage = NSEntityDescription.insertNewObject(forEntityName: "Language", into: context)
        
        newLanguage.setValue("it", forKey: "country")
        
        do {
            try context.save()
            print("save")
        }catch {
            print("erro")
        }
        
        
        let splashView = SplashView()
        splashView.modalPresentationStyle = .fullScreen
        self.present(splashView, animated: true, completion: nil)
    }
    
    @objc func hollandAction() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let newLanguage = NSEntityDescription.insertNewObject(forEntityName: "Language", into: context)
        
        newLanguage.setValue("nl", forKey: "country")
        
        do {
            try context.save()
            print("save")
        }catch {
            print("erro")
        }
        
        let splashView = SplashView()
        splashView.modalPresentationStyle = .fullScreen
        self.present(splashView, animated: true, completion: nil)
    }
    
    

     func actionLanguageLeft_tr() {
         changeLanguage(str: "tr") // turkish
     }
     
     func actionLanguageLeft_de() {
         changeLanguage(str: "de") //german
     }
     
     
     func actionLanguageLeft_en() {
         changeLanguage(str: "en") // engilsh
     }
     
    
     func actionLanguageLeft_ar() {
         
                 changeLanguage(str: "ar") //arabic
     }
     
     func actionLanguageLeft_fr() {
            changeLanguage(str: "ru")  //russian
        }
    
    
    func actionLanguageLeft_ru() {
        changeLanguage(str: "ru")  //russian
    }
    
    
    func actionLanguageLeft_da() {
        changeLanguage(str: "da") //danish
    }
    
    
    func actionLanguageLeft_it() {
        changeLanguage(str: "en")  //french
    }
    
    
    func actionLanguageLeft_nl() {
        changeLanguage(str: "nl")  //duct flemence
    }
    
    
    
    
    
}


extension LeftMenu : UITableViewDataSource,UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 71
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cellLogo : cellLogo = tableView.dequeueReusableCell(withIdentifier: "cellLogo") as! cellLogo
            return cellLogo
        } else if indexPath.row == 1 {
            let cellHesap : cellHesap = tableView.dequeueReusableCell(withIdentifier: "cellHesap") as! cellHesap
            cellHesap.lblHesap.text = lblHesap.text
            return cellHesap
        }else if indexPath.row == 2 {
            let cellAnaSayfa : cellAnaSayfa = tableView.dequeueReusableCell(withIdentifier: "cellAnaSayfa") as! cellAnaSayfa
            cellAnaSayfa.lblAnaSayfa.text = lblAnaSayfa.text
            return cellAnaSayfa
        }else if indexPath.row == 3 {
            let cellKonum : cellKonum = tableView.dequeueReusableCell(withIdentifier: "cellKonum") as! cellKonum
            cellKonum.lblKonum.text = lblKonumunuGuncelle.text
            return cellKonum
        }else if indexPath.row == 4 {
            let cellDil : cellDil = tableView.dequeueReusableCell(withIdentifier: "cellDil") as! cellDil
            cellDil.lblDil.text = lblDiliDegistir.text
            return cellDil
        }else if indexPath.row == 5 {
            let cellCik : cellCik = tableView.dequeueReusableCell(withIdentifier: "cellCik") as! cellCik
            cellCik.lblCikis.text = lblCikisYap.text
            return cellCik
        }else if indexPath.row == 6 {
            let cellKategori : cellKategori = tableView.dequeueReusableCell(withIdentifier: "cellKategori") as! cellKategori
            cellKategori.lblKategori.text = lblKategoriler.text
            return cellKategori
        }else if indexPath.row == 7 {
            let cellMarket : cellMarket = tableView.dequeueReusableCell(withIdentifier: "cellMarket") as! cellMarket
            cellMarket.lblAvukat.text = lblAvukat.text
            return cellMarket
        }else if indexPath.row == 8 {
            let cellEczane : cellEczane = tableView.dequeueReusableCell(withIdentifier: "cellEczane") as! cellEczane
            cellEczane.lblAraba.text = lblArabaTamir.text
            return cellEczane
        }else if indexPath.row == 9 {
            let cellOtel : cellOtel = tableView.dequeueReusableCell(withIdentifier: "cellOtel") as! cellOtel
            cellOtel.lblArabaParca.text = lblArabaParca.text
            return cellOtel
        }else if indexPath.row == 10 {
            let cellBankamatik : cellBankamatik = tableView.dequeueReusableCell(withIdentifier: "cellBankamatik") as! cellBankamatik
            cellBankamatik.lblAv.text = lblAv.text
            return cellBankamatik
        }else if indexPath.row == 11 {
            let cellPtt : cellPtt = tableView.dequeueReusableCell(withIdentifier: "cellPtt") as! cellPtt
            cellPtt.lblBanka.text = lblBanka.text
            return cellPtt
        }else if indexPath.row == 12 {
            let cellBerber : cellBerber = tableView.dequeueReusableCell(withIdentifier: "cellBerber") as! cellBerber
            cellBerber.lblBankamatik.text = lblBankamatik.text
            return cellBerber
        }else if indexPath.row == 13 {
            let cellRestoran : cellRestoran = tableView.dequeueReusableCell(withIdentifier: "cellRestoran") as! cellRestoran
            cellRestoran.lblBelediyye.text = lblBelediye.text
            return cellRestoran
        }else if indexPath.row == 14 {
            let cellTerzi : cellTerzi = tableView.dequeueReusableCell(withIdentifier: "cellTerzi") as! cellTerzi
            cellTerzi.lblBerber.text = lblBerber.text
            return cellTerzi
        }else if indexPath.row == 15 {
            let cellTerzi2 : cellTerzi2 = tableView.dequeueReusableCell(withIdentifier: "cellTerzi2") as! cellTerzi2
            cellTerzi2.lblBenzinlik.text = lblBenzinlik.text
            return cellTerzi2
        }else if indexPath.row == 16 {
            let cellTerzi3 : cellTerzi3 = tableView.dequeueReusableCell(withIdentifier: "cellTerzi3") as! cellTerzi3
            cellTerzi3.lblBilgisayar.text = lblBilgisayar.text
            return cellTerzi3
        }else if indexPath.row == 17 {
            let cellTerzi4 : cellTerzi4 = tableView.dequeueReusableCell(withIdentifier: "cellTerzi4") as! cellTerzi4
            cellTerzi4.lblBisiklet.text = lblBisiklet.text
            return cellTerzi4
        }else if indexPath.row == 18 {
            let cellTerzi5 : cellTerzi5 = tableView.dequeueReusableCell(withIdentifier: "cellTerzi5") as! cellTerzi5
            cellTerzi5.lblBeyazEsya.text = lblBeyazEsya.text
            return cellTerzi5
        }else if indexPath.row == 19 {
            let cellTerzi6 : cellTerzi6 = tableView.dequeueReusableCell(withIdentifier: "cellTerzi6") as! cellTerzi6
            cellTerzi6.lblCafe.text = lblCafe.text
            return cellTerzi6
        }else if indexPath.row == 20 {
            let cellTerzi7 : cellTerzi7 = tableView.dequeueReusableCell(withIdentifier: "cellTerzi7") as! cellTerzi7
            cellTerzi7.lblCepTelefonu.text = lblCepTelefonu.text
            return cellTerzi7
        }else if indexPath.row == 21 {
            let cellTerzi8 : cellTerzi8 = tableView.dequeueReusableCell(withIdentifier: "cellTerzi8") as! cellTerzi8
            cellTerzi8.lblCicekci.text = lblCicekci.text
            return cellTerzi8
        }else if indexPath.row == 22 {
            let cellTerzi9 : cellTerzi9 = tableView.dequeueReusableCell(withIdentifier: "cellTerzi9") as! cellTerzi9
            cellTerzi9.lblCocukParki.text = lblCocukParki.text
            return cellTerzi9
        }else if indexPath.row == 23 {
            let cellTerzi10 : cellTerzi10 = tableView.dequeueReusableCell(withIdentifier: "cellTerzi10") as! cellTerzi10
            cellTerzi10.lblDershane.text = lblDershane.text
            return cellTerzi10
        }else if indexPath.row == 24 {
            let cellTerzi11 : cellTerzi11 = tableView.dequeueReusableCell(withIdentifier: "cellTerzi11") as! cellTerzi11
            cellTerzi11.lblDugun.text = lblDugun.text
            return cellTerzi11
        }else if indexPath.row == 25 {
            let cellTerzi12 : cellTerzi12 = tableView.dequeueReusableCell(withIdentifier: "cellTerzi12") as! cellTerzi12
            cellTerzi12.lblEczane.text = lblEczane.text
            return cellTerzi12
        }else if indexPath.row == 26 {
            let cellTerzi13 : cellTerzi13 = tableView.dequeueReusableCell(withIdentifier: "cellTerzi13") as! cellTerzi13
            cellTerzi13.lblEglence.text = lblEglence.text
            return cellTerzi13
        }else if indexPath.row == 27 {
            let cellTerzi14 : cellTerzi14 = tableView.dequeueReusableCell(withIdentifier: "cellTerzi14") as! cellTerzi14
            cellTerzi14.lblEhliyet.text = lblEhliytet.text
            return cellTerzi14
        }else if indexPath.row == 28 {
            let cellTerzi15 : cellTerzi15 = tableView.dequeueReusableCell(withIdentifier: "cellTerzi15") as! cellTerzi15
            cellTerzi15.lblElektronik.text = lblElektronik.text
            return cellTerzi15
        }else if indexPath.row == 29 {
            let cellTerzi16 : cellTerzi16 = tableView.dequeueReusableCell(withIdentifier: "cellTerzi16") as! cellTerzi16
            cellTerzi16.lblFabrika.text = lblFabrika.text
            return cellTerzi16
        }else if indexPath.row == 30 {
            let cellTerzi17 : cellTerzi17 = tableView.dequeueReusableCell(withIdentifier: "cellTerzi17") as! cellTerzi17
            cellTerzi17.lblFirin.text = lblFirin.text
            return cellTerzi17
        }else if indexPath.row == 31 {
            let cellTerzi18 : cellTerzi18 = tableView.dequeueReusableCell(withIdentifier: "cellTerzi18") as! cellTerzi18
            cellTerzi18.lblHastane.text = lblHastane.text
            return cellTerzi18
        }else if indexPath.row == 32 {
            let cellTerzi19 : cellTerzi19 = tableView.dequeueReusableCell(withIdentifier: "cellTerzi19") as! cellTerzi19
            cellTerzi19.lblHamam.text = lblHamam.text
            return cellTerzi19
        }else if indexPath.row == 33 {
            let cellTerzi20 : cellTerzi20 = tableView.dequeueReusableCell(withIdentifier: "cellTerzi20") as! cellTerzi20
            cellTerzi20.lblGiyim.text = lblGiyim.text
            return cellTerzi20
        }else if indexPath.row == 34 {
            let cellTerzi21 : cellTerzi21 = tableView.dequeueReusableCell(withIdentifier: "cellTerzi21") as! cellTerzi21
            cellTerzi21.lblGuzellik.text = lblGuzellikSalonu.text
            return cellTerzi21
        }else if indexPath.row == 35 {
            let cellTerzi22 : cellTerzi22 = tableView.dequeueReusableCell(withIdentifier: "cellTerzi22") as! cellTerzi22
            cellTerzi22.lblKasap.text = lblKasap.text
            return cellTerzi22
        }else if indexPath.row == 36 {
            let cellTerzi23 : cellTerzi23 = tableView.dequeueReusableCell(withIdentifier: "cellTerzi23") as! cellTerzi23
            cellTerzi23.lblKirtasiye.text = lblKirtasiye.text
            return cellTerzi23
        }else if indexPath.row == 37 {
            let cellTerzi24 : cellTerzi24 = tableView.dequeueReusableCell(withIdentifier: "cellTerzi24") as! cellTerzi24
            cellTerzi24.lblKres.text = lblKres.text
            return cellTerzi24
        }else if indexPath.row == 38 {
            let cellTerzi25 : cellTerzi25 = tableView.dequeueReusableCell(withIdentifier: "cellTerzi25") as! cellTerzi25
            cellTerzi25.lblKonsulluk.text = lblKonsulluk.text
            return cellTerzi25
        }else if indexPath.row == 39 {
            let cellTerzi26 : cellTerzi26 = tableView.dequeueReusableCell(withIdentifier: "cellTerzi26") as! cellTerzi26
            cellTerzi26.lblKozmetik.text = lblKozmetik.text
            return cellTerzi26
        }else if indexPath.row == 40 {
            let cellTerzi27 : cellTerzi27 = tableView.dequeueReusableCell(withIdentifier: "cellTerzi27") as! cellTerzi27
            cellTerzi27.lblKursYerleri.text = lblKursYerleri.text
            return cellTerzi27
        }else if indexPath.row == 41 {
            let cellTerzi28 : cellTerzi28 = tableView.dequeueReusableCell(withIdentifier: "cellTerzi28") as! cellTerzi28
            cellTerzi28.lblKuruTemizleme.text = lblKuruTemizleme.text
            return cellTerzi28
        }else if indexPath.row == 42 {
            let cellTerzi29 : cellTerzi29 = tableView.dequeueReusableCell(withIdentifier: "cellTerzi29") as! cellTerzi29
            cellTerzi29.lblKucukIlan.text = lblKucukIlan.text
            return cellTerzi29
        }else if indexPath.row == 43 {
            let cellTerzi30 : cellTerzi30 = tableView.dequeueReusableCell(withIdentifier: "cellTerzi30") as! cellTerzi30
            cellTerzi30.lblLokanta.text = lblLokanta.text
            return cellTerzi30
        }else if indexPath.row == 44 {
            let cellTerzi31 : cellTerzi31 = tableView.dequeueReusableCell(withIdentifier: "cellTerzi31") as! cellTerzi31
            cellTerzi31.lblManav.text = lblmanav.text
            return cellTerzi31
        }else if indexPath.row == 45 {
            let cellTerzi32 : cellTerzi32 = tableView.dequeueReusableCell(withIdentifier: "cellTerzi32") as! cellTerzi32
            cellTerzi32.lblMasaj.text = lblMasaj.text
            return cellTerzi32
        }else if indexPath.row == 46 {
            let cellTerzi33 : cellTerzi33 = tableView.dequeueReusableCell(withIdentifier: "cellTerzi33") as! cellTerzi33
            cellTerzi33.lblMarangoz.text = lblMarangoz.text
            return cellTerzi33
        }else if indexPath.row == 47 {
            let cellTerzi34 : cellTerzi34 = tableView.dequeueReusableCell(withIdentifier: "cellTerzi34") as! cellTerzi34
            cellTerzi34.lblMarket.text = lblMarket.text
            return cellTerzi34
        }else if indexPath.row == 48 {
            let cellTerzi35 : cellTerzi35 = tableView.dequeueReusableCell(withIdentifier: "cellTerzi35") as! cellTerzi35
            cellTerzi35.lblMobilya.text = lblMobilya.text
            return cellTerzi35
        }else if indexPath.row == 49 {
            let cellTerzi36 : cellTerzi36 = tableView.dequeueReusableCell(withIdentifier: "cellTerzi36") as! cellTerzi36
            cellTerzi36.lblMuhasebe.text = lblMuhasabe.text
            return cellTerzi36
        }else if indexPath.row == 50 {
            let cellTerzi37 : cellTerzi37 = tableView.dequeueReusableCell(withIdentifier: "cellTerzi37") as! cellTerzi37
            cellTerzi37.lblMuzik.text = lblMuzik.text
            return cellTerzi37
        }else if indexPath.row == 51 {
            let cellTerzi38 : cellTerzi38 = tableView.dequeueReusableCell(withIdentifier: "cellTerzi38") as! cellTerzi38
            cellTerzi38.lblNufus.text = lblNufus.text
            return cellTerzi38
        }else if indexPath.row == 52 {
            let cellTerzi39 : cellTerzi39 = tableView.dequeueReusableCell(withIdentifier: "cellTerzi39") as! cellTerzi39
            cellTerzi39.lblOkul.text = lblOkul.text
            return cellTerzi39
        }else if indexPath.row == 53 {
            let cellTerzi40 : cellTerzi40 = tableView.dequeueReusableCell(withIdentifier: "cellTerzi40") as! cellTerzi40
            cellTerzi40.lblOtel.text = lblOtel.text
            return cellTerzi40
        }else if indexPath.row == 54 {
            let cellTerzi41 : cellTerzi41 = tableView.dequeueReusableCell(withIdentifier: "cellTerzi41") as! cellTerzi41
            cellTerzi41.lblOtopark.text = lblotoPark.text
            return cellTerzi41
        }else if indexPath.row == 55 {
            let cellTerzi42 : cellTerzi42 = tableView.dequeueReusableCell(withIdentifier: "cellTerzi42") as! cellTerzi42
            cellTerzi42.lblOrganzisyon.text = lblOrganizasyon.text
            return cellTerzi42
        }else if indexPath.row == 56 {
            let cellTerzi43 : cellTerzi43 = tableView.dequeueReusableCell(withIdentifier: "cellTerzi43") as! cellTerzi43
            cellTerzi43.lblOzelOkul.text = lblOzelOkul.text
            return cellTerzi43
        }else if indexPath.row == 57 {
            let cellTerzi44 : cellTerzi44 = tableView.dequeueReusableCell(withIdentifier: "cellTerzi44") as! cellTerzi44
            cellTerzi44.lblPasthane.text = lblPastane.text
            return cellTerzi44
        }else if indexPath.row == 58 {
            let cellTerzi45 : cellTerzi45 = tableView.dequeueReusableCell(withIdentifier: "cellTerzi45") as! cellTerzi45
            cellTerzi45.lblPolisKarakolu.text = lblPolisOkulu.text
            return cellTerzi45
        }
        else if indexPath.row == 59 {
            let cellTerzi46 : cellTerzi46 = tableView.dequeueReusableCell(withIdentifier: "cellTerzi46") as! cellTerzi46
            cellTerzi46.lblPtt.text = lblPtt.text
            return cellTerzi46
        }else if indexPath.row == 60 {
            let cellTerzi47 : cellTerzi47 = tableView.dequeueReusableCell(withIdentifier: "cellTerzi47") as! cellTerzi47
            cellTerzi47.lblRestorant.text = lblRestoren.text
            return cellTerzi47
        }else if indexPath.row == 61 {
            let cellTerzi48 : cellTerzi48 = tableView.dequeueReusableCell(withIdentifier: "cellTerzi48") as! cellTerzi48
            cellTerzi48.lblSarraf.text = lblSarraf.text
            return cellTerzi48
        }else if indexPath.row == 62 {
            let cellTerzi49 : cellTerzi49 = tableView.dequeueReusableCell(withIdentifier: "cellTerzi49") as! cellTerzi49
            cellTerzi49.lblSerbestMeslek.text = lblSerbestMeslek.text
            return cellTerzi49
        }else if indexPath.row == 63 {
            let cellTerzi50 : cellTerzi50 = tableView.dequeueReusableCell(withIdentifier: "cellTerzi50") as! cellTerzi50
            cellTerzi50.lblSinema.text = lblSinema.text
            return cellTerzi50
        }else if indexPath.row == 64 {
            let cellTerzi51 : cellTerzi51 = tableView.dequeueReusableCell(withIdentifier: "cellTerzi51") as! cellTerzi51
            cellTerzi51.lblSigorta.text = lblSigorta.text
            return cellTerzi51
        }else if indexPath.row == 65 {
            let cellTerzi52 : cellTerzi52 = tableView.dequeueReusableCell(withIdentifier: "cellTerzi52") as! cellTerzi52
            cellTerzi52.lblSpor.text = lblSpor.text
            return cellTerzi52
            
            
        }else if indexPath.row == 66 {
            let cellTerzi53 : cellTerzi53 = tableView.dequeueReusableCell(withIdentifier: "cellTerzi53") as! cellTerzi53
            cellTerzi53.lblTatilYeri.text = lblTatilYeri.text
            return cellTerzi53
        }else if indexPath.row == 67 {
            let cellTerzi54 : cellTerzi54 = tableView.dequeueReusableCell(withIdentifier: "cellTerzi54") as! cellTerzi54
            cellTerzi54.lblTemizlik.text = lblTemizlik.text
            return cellTerzi54
        }else if indexPath.row == 68 {
            let cellTerzi55 : cellTerzi55 = tableView.dequeueReusableCell(withIdentifier: "cellTerzi55") as! cellTerzi55
            cellTerzi55.lblTercume.text = lbltercume.text
            return cellTerzi55
        }else if indexPath.row == 69 {
            let cellTerzi56 : cellTerzi56 = tableView.dequeueReusableCell(withIdentifier: "cellTerzi56") as! cellTerzi56
            cellTerzi56.lblTerzi.text = lblterzi.text
            return cellTerzi56
        }else if indexPath.row == 70 {
            let cellTerzi57 : cellTerzi57 = tableView.dequeueReusableCell(withIdentifier: "cellTerzi57") as! cellTerzi57
            cellTerzi57.lblToptanci.text = lblToptanci.text
            return cellTerzi57
        }
        
        let cellTerzi : cellTerzi = tableView.dequeueReusableCell(withIdentifier: "cellTerzi") as! cellTerzi
        return cellTerzi
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 100
        }
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            //none
        }else if indexPath.row == 1 {
            //none
        }else if indexPath.row == 2 {
            
            Cache.filterkeyword = ""
            NotificationCenter.default.post(name: Notification.Name("ReceiveData"), object: nil)
            
            self.dismiss(animated: true, completion: nil)
            
            
        }else if indexPath.row == 3 {
            
            let userid = Auth.auth().currentUser!.uid
            var ref : DatabaseReference?
            ref = Database.database().reference().child("user").child(userid)
            
            let dict : [String:Any] = ["latitude":lattitude,"longitude":longitude]
            ref?.updateChildValues(dict)
            
            
            
            
            
            let refreshAlert = UIAlertController(title: "", message: Alert5.text, preferredStyle: UIAlertController.Style.alert)
            
            refreshAlert.addAction(UIAlertAction(title: Alert6.text, style: .default, handler: { (action: UIAlertAction!) in
                do {
                    self.dismiss(animated: true, completion: nil)
                    self.view.endEditing(true)
                    
                } catch {
                    print("error")
                }
            }))
            present(refreshAlert, animated: true, completion: nil)
            
            
        }else if indexPath.row == 4 {
            //            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            //            let vc = storyboard.instantiateViewController(withIdentifier: "Home") as! Home
            //            vc.modalPresentationStyle = .fullScreen
            //            vc.isHiddenn = "false"
            //            self.present(vc, animated: true, completion: nil)
            
            visualEffectView.isHidden = false
            stackView.isHidden = false
            stackView2.isHidden = false
            stackView3.isHidden = false
            

            
        }else if indexPath.row == 5 {
            let refreshAlert = UIAlertController(title: Alert1.text, message: Alert2.text, preferredStyle: UIAlertController.Style.alert)
            
            refreshAlert.addAction(UIAlertAction(title: Alert3.text, style: .default, handler: { (action: UIAlertAction!) in
                do {
                    try Auth.auth().signOut()
                    let login = SignIn()
                    login.modalPresentationStyle = .fullScreen
                    self.present(login, animated: true, completion: nil)
                    
                    
                } catch {
                    print("error")
                }
            }))
            
            refreshAlert.addAction(UIAlertAction(title: Alert4.text, style: .cancel, handler: { (action: UIAlertAction!) in
                self.dismiss(animated: true, completion: nil)
                self.view.endEditing(true)
                
            }))
            
            present(refreshAlert, animated: true, completion: nil)
        }else if indexPath.row == 6 {
            
        }else {
            let kategoriArrayEng = ["Lawyer","Car Repair","Car Track","Hunting Equipment","Bank","Cash dispenser","Municipality","Barber","Petrol station","Computer","Bike","Household appliances","Cafe","Mobile phone","Florist","Child park","Class","Wedding","Pharmacy","Entertainment","Driving license","Electronic","Factory","Bakery","Hospital","Bath","Clothing","Beauty centre","Butcher","Stationery","Nursery","Consular","Cosmetic","Course Locations","Dry cleaner","Small Ad","Restaurant","Greengrocer","Massage","Carpenter","Market","Furniture","Accounting","Music","Population","School","Hotel","Car park","Organization","Private school","Patisserie","Police station","PTT","Restaurant","Moneychanger","Self-employment","Cinema","Insurance","Sport","Resort","Cleaning","Translation","Tailor","Wholesaler"]
            
            print("\(kategoriArrayEng[indexPath.row-7])")
            
            Cache.filterkeyword = "\(kategoriArrayEng[indexPath.row-7])"
            NotificationCenter.default.post(name: Notification.Name("ReceiveData"), object: nil) 
            self.dismiss(animated: true, completion: nil)
            
        }
        
        
    }
    
}
