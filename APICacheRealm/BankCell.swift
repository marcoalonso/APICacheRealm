//
//  BankCell.swift
//  APICacheRealm
//
//  Created by Marco Alonso Rodriguez on 28/05/23.
//

import UIKit
import Kingfisher

class BankCell: UITableViewCell {
    
    @IBOutlet weak var nameBank: UILabel!
    @IBOutlet weak var bankImage: UIImageView!
    @IBOutlet weak var bankDescription: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupCell(bank: BankObject) {
        nameBank.text = bank.bankName
        bankDescription.text = bank.description
        
        bankImage.loadFrom(URLAddress: bank.url)
        bankImage.layer.cornerRadius = 12
        bankImage.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension UIImageView {
    func loadFrom(URLAddress: String) {
        guard let url = URL(string: URLAddress) else {
            return
        }
        
        let session = URLSession(configuration: .default)
        
        let tarea = session.dataTask(with: url) { datos, _, error in
            if let datosSeguros = datos {
                if let loadedImage = UIImage(data: datosSeguros) {
                    DispatchQueue.main.async {
                        self.image = loadedImage
                    }
                }
            }
        }
        tarea.resume()
    }
}
