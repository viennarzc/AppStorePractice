//
//  MainViewController.swift
//  AppStorePractice
//
//  Created by Viennarz Curtiz on 6/1/21.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
	
	var selectedCompLayout: ViewController.CompLayout = .one
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		
		if let vc = segue.destination as? ViewController {
			vc.selectedCompLayout = selectedCompLayout
		}
        
    }
    
	
	
	@IBAction func didTapButton(_ sender: UIButton) {
		
		var identifier: String = ""
		
		if sender.currentTitle == "Style 1" {
			selectedCompLayout = .one
			identifier = "ViewController"
			
		} else if sender.currentTitle == "Style 2" {
			selectedCompLayout = .two
			identifier = "ViewController"
			
		} else if sender.currentTitle == "Style 3" {
			selectedCompLayout = .three
			identifier = "ViewController"
			
		} else if sender.currentTitle == "Style 4" {
			selectedCompLayout = .four
			identifier = "ViewController"
			
		} else if sender.currentTitle == "AppStore Games" {
			identifier = "ToAppStoreGames"
		}
		
		
		performSegue(withIdentifier: identifier, sender: self)

	}
	
}
