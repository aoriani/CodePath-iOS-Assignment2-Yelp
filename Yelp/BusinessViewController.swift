//
//  ViewController.swift
//  Yelp
//
//  Created by Andre Oriani on 2/10/16.
//  Copyright © 2016 Orion. All rights reserved.
//

import UIKit
import CoreLocation
import MBProgressHUD
import MapKit

class BusinessViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate, FilterViewControllerDelegate, MKMapViewDelegate {
    
    enum Mode {
        case List, Map
    }
    
    @IBOutlet var topView: UIView!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    let searchBar = UISearchBar()
    
    var dataSource: BusinessDataSource!
    var currentSearchTask: NetTask?
    var filterRecipe = FilterRecipe.emptyFilter
    var searchTerm = "churrasco"
    var mode = Mode.List {
        didSet {
            updateMode()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        tableView.delegate = self
        dataSource = BusinessDataSource(forTable: tableView)
        
    
        searchBar.sizeToFit()
        searchBar.text = searchTerm
        searchBar.placeholder = "e.g. Gnocchi, delivery, TGI Fridays"
        searchBar.delegate = self
        navigationItem.titleView = searchBar
        
        mapView.delegate = self
        updateMode()
        updateMap(LocationManager.sharedInstance.getLastKnownLocation())
        
        performSearch()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBAction func onTapOutside(sender: AnyObject) {
        searchBar.resignFirstResponder()
    }
    
    private func updateMode() {
        tableView.hidden = (mode != .List)
        mapView.hidden = (mode != .Map)
    }
    
    func performSearch() {
        currentSearchTask?.cancel()
        let progressDialog = MBProgressHUD.showHUDAddedTo(topView, animated: true)
        progressDialog.color = UIColor.redColor()
        progressDialog.labelText = "Searching \(searchTerm)..."
        progressDialog.show(true)
        let searchLocation = LocationManager.sharedInstance.getLastKnownLocation()
        currentSearchTask = YelpService.sharedInstance.newRequest(searchLocation).searchTerm(searchTerm).filters(filterRecipe).execute(onSuccess: {
                result in
                    progressDialog.hide(true)
                    self.dataSource.setItems(result.businesses)
                    self.updateMap(searchLocation, businesses: result.businesses)
            },
            onFailure: {
                progressDialog.hide(true)
                self.dataSource.setItems([])
            }
        )
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        if let searchTermFull = searchBar.text {
            let searchTerm = searchTermFull.trim()
            if !searchTerm.isEmpty {
                self.searchTerm = searchTerm
                performSearch()
            }
        }
        searchBar.resignFirstResponder()
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func filterViewController(filterViewController: FilterViewController, didFilterChange: FilterRecipe) {
        self.filterRecipe = didFilterChange
        performSearch()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let segueIdentifier = segue.identifier {
            if segueIdentifier == "filterRoute" {
                let navController = segue.destinationViewController as! UINavigationController
                let filtersViewController = navController.topViewController as! FilterViewController
                filtersViewController.delegate = self
                filtersViewController.filterRecipe = filterRecipe
            } else if segueIdentifier == "businessDetailsRoute" {
                let cell = sender as! UITableViewCell
                let indexPath = tableView.indexPathForCell(cell)!
                let selectedBusiness = dataSource.getItem(indexPath.row)
                let detailController = segue.destinationViewController as! BusinessDetailsViewController
                detailController.business = selectedBusiness
            }
        }
    }

    @IBAction func onModeSegmentedControlChanged(sender: AnyObject) {
        mode = (segmentedControl.selectedSegmentIndex == 0) ? .List : .Map
    }
    
    private func updateMap(latlon: LocationManager.LatLon, businesses: [Business]? = nil) {
        let mapCenterLocation = CLLocation(latitude:latlon.lat, longitude: latlon.lon)
        let span = MKCoordinateSpanMake(0.1, 0.1)
        let region = MKCoordinateRegionMake(mapCenterLocation.coordinate, span)
        
        mapView.removeAnnotations(mapView.annotations)
        if businesses != nil && !(businesses!.isEmpty) {
            for business in businesses! {
                mapView.addAnnotation(MapAnnotation(business: business))
            }
        }
        
        mapView.setRegion(region, animated: true)
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        if let businessAnnotation = annotation as? MapAnnotation {
            let reuseId = "businessPin"
            var annotationView:MKPinAnnotationView
            if let annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId) {
                annotationView.annotation = businessAnnotation
                return annotationView
            } else {
                annotationView = MKPinAnnotationView(annotation: businessAnnotation, reuseIdentifier: reuseId)
                annotationView.canShowCallout = true
                annotationView.calloutOffset = CGPoint(x: -5, y: 5)
                let infoButton = UIButton(type: .DetailDisclosure)
                infoButton.tintColor = UIColor.redColor()
                annotationView.rightCalloutAccessoryView = infoButton as UIView
                annotationView.animatesDrop = true
                return annotationView
            }
        } else {
            return nil
        }
    }
    
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let annotation = view.annotation as! MapAnnotation
        let businessDetailsViewController = self.storyboard?.instantiateViewControllerWithIdentifier("businessDetailsController") as! BusinessDetailsViewController
        businessDetailsViewController.business = annotation.business
        self.navigationController?.pushViewController(businessDetailsViewController, animated: true)
    }
}

