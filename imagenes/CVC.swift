//
//  CVC.swift
//  imagenes
//
//  Created by SebasFiol on 10/8/16.
//  Copyright © 2016 SebasFiol. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

struct Seccion {
    var nombre : String
    var imagenes : [UIImage]
    
    init(nombre : String, imagenes : [UIImage]) {
        self.nombre = nombre
        self.imagenes = imagenes
    }
}

class CVC: UICollectionViewController {
    
    var imagenes = [Seccion]()
    
    func busquedaGoogle(termino : String) -> [UIImage] {
        var imgs = [UIImage]()
        let urls = "https://api.flickr.com/services/feeds/photos_public.gne?tagmode=any&format=json&nojsoncallback=1&tags=" + termino
        let url = NSURL(string: urls)
        let datos = NSData(contentsOfURL: url!)
        do {
            let json = try NSJSONSerialization.JSONObjectWithData(datos!, options: NSJSONReadingOptions.MutableLeaves)
            let resultados = json["items"] as! NSArray
            for elemento in resultados {
                let dico = elemento as! NSDictionary
                let dico2 = dico["media"] as! NSDictionary
                let img_urls = dico2["m"] as! String
                let img_url = NSURL(string: img_urls)
                let img_datos = NSData(contentsOfURL: img_url!)
                if let imagen = UIImage(data: img_datos!) {
                    imgs.append(imagen)
                }
            }
        }
        catch {
            
        }
        
        return imgs
    }

    @IBAction func buscar(sender: UITextField) {
        let seccion = Seccion(nombre: sender.text!, imagenes: busquedaGoogle(sender.text!))
        imagenes.append(seccion)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 0
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath)
    
        // Configure the cell
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */

}
