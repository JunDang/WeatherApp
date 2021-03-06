//
//  WeatherViewController.swift
//  WeatherApp
//
//  Created by Jun Dang on 16/1/23.
//  Copyright © 2016年 Jun Dang. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController , UIScrollViewDelegate, UITableViewDelegate, UINavigationBarDelegate, LocationServiceDelegate {
    
    var BackgroundScrollView: UIScrollView!
    var ForegroundScrollView: UIScrollView!
    var backgroundImageView: UIImageView!
    var screenHeight: CGFloat!
    var blurredImageView: UIImageView!
    var containerView1: UIView?
    var containerView2: UIView?
    var containerView3: UIView?
    var containerView4: UIView?
    let screenWidth: CGFloat = UIScreen.mainScreen().bounds.width
    var locationLabel: UILabel?
    var temperatureLabel: UILabel?
    var feelsLikeTemperature: UILabel?
    var minutelySummary: UILabel?
    var hiLabel: UILabel?
    var lowLabel: UILabel?
    var weathericon2: UIImageView?
    var weathericon2Label: UILabel?
    var weatherDescription: UILabel?
    var weatherTableViewController: WeatherTableViewController?
    let screenSize: CGRect = UIScreen.mainScreen().bounds
    var forecastGraphs: Graphs?
    var forecastSummary: Summary?
    var airQuality: AirQuality?
    var searchCity: SearchCityViewController?
    let menuButton:UIButton = UIButton()
    var sideBar: SideBar = SideBar()
    var sideBarTableViewController: SideBarTableViewController = SideBarTableViewController()
    var refreshControl: UIRefreshControl!
    private var locationService: LocationService!
    var dateFormatter = NSDateFormatter()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //background
        self.view.backgroundColor = UIColor.blackColor()
        screenHeight = screenSize.height
        backgroundImageView = UIImageView(image: UIImage(named: "background"))
        backgroundImageView?.contentMode = UIViewContentMode.ScaleAspectFill
        backgroundImageView?.clipsToBounds = true
        backgroundImageView!.setNeedsDisplay()
        
        setUpBackgroundScrollView()
        setUpForegroundScrollView()
       
        viewModel = WeatherViewModel()
        viewModel?.startLocationService()
        // add refresh time
        self.dateFormatter.dateStyle = NSDateFormatterStyle.ShortStyle
        self.dateFormatter.timeStyle = NSDateFormatterStyle.LongStyle
        
        
    }

    func setUpBackgroundScrollView() {
       
        //add background ScrollView
        
        BackgroundScrollView = UIScrollView(frame: view.bounds)
        BackgroundScrollView.backgroundColor = UIColor.clearColor()
        BackgroundScrollView.contentSize = backgroundImageView.bounds.size
        BackgroundScrollView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        BackgroundScrollView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        BackgroundScrollView.addSubview(backgroundImageView!)
        
        //add blur image view
        
        blurredImageView = UIImageView(image: UIImage(named: "background"))
        blurredImageView?.contentMode = UIViewContentMode.ScaleAspectFill
        blurredImageView?.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: screenHeight*2)
        //blurredImageView?.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: screenHeight)
        blurredImageView!.alpha = 0
        blurredImageView?.setImageToBlur(UIImage(named: "background"), blurRadius: 10, completionBlock: nil)
        blurredImageView.translatesAutoresizingMaskIntoConstraints = false
        blurredImageView!.setNeedsDisplay()
        BackgroundScrollView.addSubview(blurredImageView)
        self.view.addSubview(BackgroundScrollView)
        self.BackgroundScrollView.delegate = self
        
        let heightBScrollView = NSLayoutConstraint(item: BackgroundScrollView,
            attribute: .Height, relatedBy: .Equal, toItem: self.view,
            attribute: .Height, multiplier: 1, constant: 0)
        let widthBScrollView = NSLayoutConstraint(item: BackgroundScrollView,
            attribute: .Width, relatedBy: .Equal, toItem: self.view,
            attribute: .Width, multiplier: 1, constant: 0)
        NSLayoutConstraint.activateConstraints([heightBScrollView, widthBScrollView])
        
        let heightBImageView = NSLayoutConstraint(item: backgroundImageView,
            attribute: .Height, relatedBy: .Equal, toItem: BackgroundScrollView,
            attribute: .Height, multiplier: 1, constant: 0) //constant: screenHeight
        let widthBImageView = NSLayoutConstraint(item: backgroundImageView,
            attribute: .Width, relatedBy: .Equal, toItem: BackgroundScrollView,
            attribute: .Width, multiplier: 1, constant: 0)
        NSLayoutConstraint.activateConstraints([heightBImageView, widthBImageView])
        
        let heightBlurredImageView = NSLayoutConstraint(item: blurredImageView,
            attribute: .Height, relatedBy: .Equal, toItem: BackgroundScrollView,
            attribute: .Height, multiplier: 1, constant: 0)//constant: screenHeight
        
        let widthBlurredImageView = NSLayoutConstraint(item: blurredImageView,
            attribute: .Width, relatedBy: .Equal, toItem: BackgroundScrollView,
            attribute: .Width, multiplier: 1, constant: 0)
        NSLayoutConstraint.activateConstraints([heightBlurredImageView, widthBlurredImageView])
        
        //add mask to backgroundScrollView
        let maskLayer = CALayer()
        maskLayer.frame = screenSize
        maskLayer.contentsGravity = kCAGravityCenter
        maskLayer.backgroundColor = UIColor.blackColor().CGColor
        maskLayer.opacity = 0.2
        maskLayer.hidden = false
        maskLayer.masksToBounds = false
        BackgroundScrollView.layer.addSublayer(maskLayer)
        
    }
    func setUpForegroundScrollView() {
        //containerView
        let containerSize1 = CGSize(width: view.bounds.width, height: screenHeight)
        containerView1 = UIView(frame: CGRect(origin: CGPoint(x: 0, y: screenHeight + 8), size:containerSize1))
        containerView1?.backgroundColor = UIColor.clearColor()
        containerView1!.setNeedsDisplay()
        containerView1!.translatesAutoresizingMaskIntoConstraints = false
        let fheight1 = containerView1?.frame.height
       //let cheight2 = fheight1! + screenHeight + 10
    
        let containerSize2 = CGSize(width: view.bounds.width, height: screenHeight)
        containerView2 = UIView(frame: CGRect(origin: CGPoint(x: 0, y: screenHeight + 8), size:containerSize2))
        containerView2?.backgroundColor = UIColor.clearColor()
        containerView2!.setNeedsDisplay()
        containerView2!.translatesAutoresizingMaskIntoConstraints = false
        //let fheight2 = containerView2?.frame.height
        let containerSize3 = CGSize(width: view.bounds.width, height: screenHeight)
        containerView3 = UIView(frame: CGRect(origin: CGPoint(x: 0, y: screenHeight + 8), size:containerSize3))
        containerView3?.backgroundColor = UIColor.clearColor()
        containerView3!.setNeedsDisplay()
        containerView3!.translatesAutoresizingMaskIntoConstraints = false
        // let fheight3 = containerView3?.frame.height
        let containerSize4 = CGSize(width: view.bounds.width, height: screenHeight)
        containerView4 = UIView(frame: CGRect(origin: CGPoint(x: 0, y: screenHeight + 8), size:containerSize4))
        containerView4?.backgroundColor = UIColor.clearColor()
        containerView4!.setNeedsDisplay()
        containerView4!.translatesAutoresizingMaskIntoConstraints = false
    
        // ForegroundScrollView
    
        ForegroundScrollView = UIScrollView(frame: view.bounds)
        ForegroundScrollView.backgroundColor = UIColor.clearColor()
        let foreHeight = fheight1!  + screenHeight + 50
        ForegroundScrollView.contentSize = CGSize(width: screenWidth, height: foreHeight)
        ForegroundScrollView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        ForegroundScrollView.translatesAutoresizingMaskIntoConstraints = false
        //ForegroundScrollView.layer.addSublayer(maskLayer)
        containerView2!.alpha = 0
        containerView3!.alpha = 0
        containerView4!.alpha = 0
        ForegroundScrollView.addSubview(containerView4!)
        ForegroundScrollView.addSubview(containerView3!)
        ForegroundScrollView.addSubview(containerView2!)
        ForegroundScrollView.addSubview(containerView1!)
    
        view.addSubview(ForegroundScrollView)
    
        ForegroundScrollView.delegate = self
    
        let heightForegroundScrollView = NSLayoutConstraint(item: ForegroundScrollView,
             attribute: .Height, relatedBy: .Equal, toItem: BackgroundScrollView,
             attribute: .Height, multiplier: 1, constant: 0)
        let widthForegroundScrollView = NSLayoutConstraint(item: ForegroundScrollView,
             attribute: .Width, relatedBy: .Equal, toItem: BackgroundScrollView,
             attribute: .Width, multiplier: 1, constant: 0)
        NSLayoutConstraint.activateConstraints([heightForegroundScrollView, widthForegroundScrollView])
        addLabelsToForegroundScrollView()
        addSegmentedControll()
        //initialize
        weatherTableViewController = WeatherTableViewController()
        forecastGraphs = Graphs()
        forecastSummary = Summary()
        airQuality = AirQuality()
        displayContentController(weatherTableViewController!)
        displayGraphs(forecastGraphs!)
        displaySummary(forecastSummary!)
        displayAirQuality(airQuality!)
        //Navigation bar
        addNavigationBar()
        searchCity = SearchCityViewController()
        //side bar
        sideBar = SideBar(sourceView: self.ForegroundScrollView)
        //pull to refresh
        pullToRefresh()
        
    }
    func addLabelsToForegroundScrollView() {
        //add location label
        locationLabel = UILabel(frame: CGRectMake(0, 20, screenWidth, 65))
        let fontLocation = UIFont(name: "HelveticaNeue-Bold", size: 22.0)
        locationLabel!.font = fontLocation
        locationLabel!.backgroundColor = UIColor.clearColor()
        locationLabel!.textColor = UIColor.whiteColor()
        locationLabel!.textAlignment = NSTextAlignment.Center
        ForegroundScrollView.addSubview(locationLabel!)
        
        //add temperature label
        temperatureLabel = UILabel(frame: CGRectMake(13, screenHeight-137, 200, 200))
        let fontTemperatureLabel = UIFont(name: "HelveticaNeue", size: 85.0)
        temperatureLabel!.font = fontTemperatureLabel
        temperatureLabel!.backgroundColor = UIColor.clearColor()
        temperatureLabel!.textColor = UIColor.whiteColor()
        temperatureLabel!.text = "20\u{00B0}"
        ForegroundScrollView.addSubview(temperatureLabel!)
        
        //add minute summary
        minutelySummary = UILabel(frame: CGRectMake(132, screenHeight-120, 250, 200))
        let fontLabel = UIFont(name: "HelveticaNeue-Bold", size: 16.0)
        minutelySummary!.numberOfLines = 2
        minutelySummary!.font = fontLabel
        minutelySummary!.backgroundColor = UIColor.clearColor()
        minutelySummary!.textColor = UIColor.whiteColor()
        
        ForegroundScrollView.addSubview(minutelySummary!)
        
        //max temperature description
        let maxTemperature = UILabel(frame: CGRectMake(98, screenHeight-125, 80, 80))
        maxTemperature.backgroundColor = UIColor.clearColor()
        maxTemperature.textColor = UIColor.whiteColor()
        maxTemperature.text = "High:"
        maxTemperature.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
        self.ForegroundScrollView.addSubview(maxTemperature)
        
        //low temperature label
        lowLabel = UILabel(frame: CGRectMake(56, screenHeight-125, 80, 80))
        lowLabel!.backgroundColor = UIColor.clearColor()
        lowLabel!.textColor = UIColor.whiteColor()
        lowLabel!.text = "20\u{00B0}"
        lowLabel!.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
        ForegroundScrollView.addSubview(lowLabel!)
        
        //min temperature description
        let minTemperature = UILabel(frame: CGRectMake(12, screenHeight-125, 80, 80))
        minTemperature.backgroundColor = UIColor.clearColor()
        minTemperature.textColor = UIColor.whiteColor()
        minTemperature.text = "Low:"
        minTemperature.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
        self.ForegroundScrollView.addSubview(minTemperature)
        
        //high temperature label
        hiLabel = UILabel(frame: CGRectMake(146, screenHeight-125, 80, 80))
        hiLabel!.backgroundColor = UIColor.clearColor()
        hiLabel!.textColor = UIColor.whiteColor()
        hiLabel!.text = "20\u{00B0}"
        hiLabel!.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
        self.ForegroundScrollView.addSubview(hiLabel!)
        
        //Feels like
        
        let feelsLike = UILabel(frame: CGRectMake(187, screenHeight-125, 95, 80))
        feelsLike.backgroundColor = UIColor.clearColor()
        feelsLike.textColor = UIColor.whiteColor()
        feelsLike.text = "Feels like:"
        feelsLike.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
        self.ForegroundScrollView.addSubview(feelsLike)
        
        //FeelsLikeTemperature
        feelsLikeTemperature = UILabel(frame: CGRectMake(276, screenHeight-125, 80, 80))
        feelsLikeTemperature!.backgroundColor = UIColor.clearColor()
        feelsLikeTemperature!.textColor = UIColor.whiteColor()
        feelsLikeTemperature!.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
        self.ForegroundScrollView.addSubview(feelsLikeTemperature!)
        
        //weathericon2Label
        weathericon2Label = UILabel(frame: CGRectMake(13, screenHeight-155, 30, 30))
        weathericon2Label!.backgroundColor = UIColor.clearColor()
        weathericon2Label!.textColor = UIColor.clearColor()
        weathericon2Label!.hidden = true
        
        //weathericon2
        weathericon2 = UIImageView(frame: CGRectMake(13, screenHeight-160, 78, 60))
        weathericon2!.image = UIImage(named: "weather-clear")
        self.ForegroundScrollView.addSubview(weathericon2!)
        
        //add weather description
        weatherDescription = UILabel(frame: CGRectMake(110, screenHeight-180, 300, 100))
        weatherDescription!.backgroundColor = UIColor.clearColor()
        weatherDescription!.textColor = UIColor.whiteColor()
        weatherDescription!.font = UIFont(name: "HelveticaNeue-Bold", size: 19)
        self.ForegroundScrollView.addSubview(weatherDescription!)
        
        
        
    }
    func addSegmentedControll() {
        let items = ["Table", "Graph", "Summary", "Air Quality"]
        let segmentedControll = UISegmentedControl(items: items)
        segmentedControll.selectedSegmentIndex = 0
        segmentedControll.frame = CGRectMake(screenSize.minX + 17, screenHeight + 5,
            screenSize.width - 18, screenSize.height*0.07)
        segmentedControll.layer.cornerRadius = 5.0  // Don't let background bleed
        segmentedControll.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.2)
        segmentedControll.tintColor = UIColor.whiteColor()
        segmentedControll.addTarget(self, action: #selector(WeatherViewController.changeDisplay(_:)), forControlEvents: .ValueChanged)
        self.ForegroundScrollView.addSubview(segmentedControll)
        

    }
    func addNavigationBar() {
        //add navigation bar
        let navigationBar = UINavigationBar(frame: CGRectMake(0, 33, self.view.frame.size.width, 40))
        navigationBar.backgroundColor = UIColor.clearColor()
        navigationBar.tintColor = UIColor.whiteColor()
        //navigationBar.translucent = true
        navigationBar.delegate = self
        let navigationItem = UINavigationItem()
        let searchButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Search, target: self, action: #selector(WeatherViewController.SearchCity(_:)))
        //set image for button
        menuButton.frame = CGRectMake(20, 35, 35, 35)
        menuButton.setImage(UIImage(named: "icon-menu-narrow-white"), forState: .Normal)
        menuButton.addTarget(self, action: #selector(WeatherViewController.menuButtonPressed(_:)), forControlEvents: .TouchUpInside)
        //assign button to navigationbar
        let menubarButton = UIBarButtonItem(customView: menuButton)
        navigationItem.leftBarButtonItem = menubarButton
        navigationItem.rightBarButtonItem = searchButton
        
        // Assign the navigation item to the navigation bar
        navigationBar.items = [navigationItem]
        
        // Make the navigation bar a subview of the current view controller
        self.ForegroundScrollView.addSubview(navigationBar)

    }
    func pullToRefresh() {
        // pull to refresh
        self.refreshControl = UIRefreshControl()
        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshControl.addTarget(self, action: #selector(WeatherViewController.pullToRefresh(_:)), forControlEvents: UIControlEvents.ValueChanged)
        self.ForegroundScrollView.addSubview(self.refreshControl)

    }
   
    func scrollViewDidScroll(scrollView: UIScrollView) {
      
        let height = scrollView.bounds.size.height
        let position =  max(scrollView.contentOffset.y, 0.0)
        let percent = min(position / height, 0.8)
        self.blurredImageView?.alpha = percent
        let foregroundHeight = ForegroundScrollView.contentSize.height - CGRectGetHeight(ForegroundScrollView.bounds)
        let percentageScroll = ForegroundScrollView.contentOffset.y / foregroundHeight
        let backgroundHeight = BackgroundScrollView.contentSize.height - CGRectGetHeight(BackgroundScrollView.bounds)
        
        BackgroundScrollView.contentOffset = CGPoint(x: 0, y: backgroundHeight * percentageScroll * 0.1)
        
        
    }
    
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        
        return UIStatusBarStyle.LightContent
        
    }
    
    func changeDisplay(sender: UISegmentedControl) {
       
        switch sender.selectedSegmentIndex {
           case 0:
                self.containerView1!.alpha = 1
                self.containerView2!.alpha = 0
                self.containerView3!.alpha = 0
                self.containerView4!.alpha = 0
           case 1:
                self.containerView1!.alpha = 0
                self.containerView2!.alpha = 1
                self.containerView3!.alpha = 0
                self.containerView4!.alpha = 0
           case 2:
                self.containerView1!.alpha = 0
                self.containerView2!.alpha = 0
                self.containerView3!.alpha = 1
                self.containerView4!.alpha = 0
           case 3:
                self.containerView1!.alpha = 0
                self.containerView2!.alpha = 0
                self.containerView3!.alpha = 0
                self.containerView4!.alpha = 1
           default:
                break
        }
    }

    
    func displayContentController(weatherTableViewController: WeatherTableViewController) {
        
        containerView1!.frame.size.height = weatherTableViewController.tableView.frame.height
        containerView1!.frame.size.width = weatherTableViewController.tableView.frame.width
        self.addChildViewController(weatherTableViewController)
        self.containerView1!.addSubview(weatherTableViewController.tableView)
        weatherTableViewController.didMoveToParentViewController(self)
        self.weatherTableViewController = weatherTableViewController
        
    }
    func displayGraphs(forecastGraphs: Graphs) {
           // containerView2!.frame.size.height = forecastGraphs.view.frame.height
            //containerView2!.frame.size.width = forecastGraphs.view.frame.width
            self.addChildViewController(forecastGraphs)
            self.containerView2!.addSubview(forecastGraphs.view)
            forecastGraphs.didMoveToParentViewController(self)
            self.forecastGraphs = forecastGraphs
            
        }
    func displaySummary(forecastSummary: Summary) {
          //containerView3!.frame.size.height = forecastSummary.view.frame.height
          //containerView3!.frame.size.width = forecastSummary.view.frame.width
            self.addChildViewController(forecastSummary)
            self.containerView3!.addSubview(forecastSummary.view)
            forecastSummary.didMoveToParentViewController(self)
            self.forecastSummary = forecastSummary
            
        }
    func displayAirQuality(airQuality: AirQuality) {
           // containerView4!.frame.size.height = airQuality.view.frame.height
          //  containerView4!.frame.size.width = airQuality.view.frame.width
            self.addChildViewController(airQuality)
            self.containerView4!.addSubview(airQuality.view)
            airQuality.didMoveToParentViewController(self)
            self.airQuality = airQuality
            
        }
    
    
    // ViewModel
    var viewModel: WeatherViewModel? {
        didSet {
            viewModel?.location.observe {
                [unowned self] in
                self.locationLabel!.text = $0
            }
            
            viewModel?.currentIconName.observe {
                [unowned self] in
                self.weathericon2Label!.text = $0
                if  !self.weathericon2Label!.text!.isEmpty {
                   self.weathericon2!.image = UIImage(named: "\(self.weathericon2Label!.text!)")
               
                   Flickr().searchFlickrForTerm(self.weathericon2Label!.text!) {(backgroundImage, error) -> Void in
                        dispatch_async(dispatch_get_main_queue(), {
                          
                            if error != nil {
                                print("The flickr service is not working.")
                                return
                            }
                            if backgroundImage == nil {
                                return
                            }
                            
                            //let resizedImage = Flickr().imageResize(backgroundImage!, sizeChange: CGSizeMake(self.screenSize.width, self.screenSize.height))
                            //let resizedImage = Flickr().sizeToFill(backgroundImage!, size: self.screenSize.size)
                            self.backgroundImageView.image = backgroundImage
                            self.backgroundImageView?.contentMode = UIViewContentMode.ScaleAspectFill
                            self.backgroundImageView?.frame = CGRect(x: 0, y: 0, width: self.screenWidth, height: self.screenHeight)
                            self.blurredImageView.image  = backgroundImage
                            self.blurredImageView?.contentMode = UIViewContentMode.ScaleAspectFill
                            self.blurredImageView?.frame = CGRect(x: 0, y: 0, width: self.screenWidth, height: self.screenHeight)
                            self.blurredImageView!.alpha = 0
                            self.blurredImageView?.setImageToBlur(backgroundImage, blurRadius: 10, completionBlock: nil)
                          
                        })
                    }

                    
                }
                
            }
            
            viewModel?.currentTemperature.observe {
                [unowned self] in
                self.temperatureLabel!.text = $0
            }
            viewModel?.currentTemperatureHigh.observe {
                [unowned self] in
                self.hiLabel!.text = $0
            }
            viewModel?.currentTemperatureLow.observe {
                [unowned self] in
                self.lowLabel!.text = $0
            }
            viewModel?.feelsLikeTemperature.observe {
                [unowned self] in
                self.feelsLikeTemperature!.text = $0
            }
            viewModel?.currentSummary.observe {
                [unowned self] in
                self.weatherDescription!.text = $0
            }
            viewModel?.minutelySummary.observe {
                [unowned self] in
                self.minutelySummary!.text = $0
            }
            viewModel?.dailySummary.observe {
                [unowned self] in
                self.forecastSummary!.dailySummary!.text = $0
            }
            viewModel?.precipitationProbability.observe {
                [unowned self] in
                self.forecastSummary!.precipitationProbability!.text = $0
            }
            viewModel?.precipitationIntensity.observe {
                [unowned self] in
                self.forecastSummary!.precipitationIntensity!.text = $0
            }
            viewModel?.dewPoint.observe {
                [unowned self] in
                self.forecastSummary!.dewPoint!.text = $0
            }
            viewModel?.humidity.observe {
                [unowned self] in
                self.forecastSummary!.humidity!.text = $0
            }
            viewModel?.windSpeed.observe {
                [unowned self] in
                self.forecastSummary!.windSpeed!.text = $0
            }
            viewModel?.sunriseTime.observe {
                [unowned self] in
                self.forecastSummary!.sunriseTime!.text = $0
            }
            viewModel?.sunsetTime.observe {
                [unowned self] in
                self.forecastSummary!.sunsetTime!.text = $0
            }
            viewModel?.cloudCover.observe {
                [unowned self] in
                self.forecastSummary!.cloudCover!.text = $0
            }
 
            viewModel?.dailyForecasts.observe {
                [unowned self] in
                self.weatherTableViewController!.updateDailyData($0)
                self.forecastGraphs!.updateDailyData($0)
            }
            viewModel?.hourlyForecasts.observe {
                [unowned self] in
                self.weatherTableViewController!.updateHourlyData($0)
                self.forecastGraphs!.updateHourlyData($0)
                
            }
            // air quality
            viewModel?.airQualityDescription.observe {
                [unowned self] in
                self.airQuality!.airQualityDescription!.text = $0
            }
            viewModel?.dominantPollutantDescription.observe {
                [unowned self] in
                self.airQuality!.dominantPollutantDescription!.text = $0
            }
            viewModel?.recommendationsChildren.observe {
                [unowned self] in
                self.airQuality!.recommendationChildren!.text = $0
            }
            viewModel?.recommendationsHealth.observe {
                [unowned self] in
                self.airQuality!.recommendationsHealth!.text = $0
            }
            viewModel?.recommendationsInside.observe {
                [unowned self] in
                self.airQuality!.recommendationsInside!.text = $0
            }
            viewModel?.recommendationsOutside.observe {
                [unowned self] in
                self.airQuality!.recommendationsOutside!.text = $0
            }
            viewModel?.recommendationsSport.observe {
                [unowned self] in
                self.airQuality!.recommendationsSport!.text = $0
            }
        }
    }
    
    func menuButtonPressed(sender: UIBarButtonItem) {
       
        sideBar.viewModel = self.viewModel
        let sideBarContainerView = UIView()
                sideBarContainerView.frame = CGRectMake(0, self.view.frame.origin.y, 150, 250)
        sideBarContainerView.backgroundColor = UIColor.clearColor()
        sideBarContainerView.clipsToBounds = false
        self.ForegroundScrollView.addSubview(sideBarContainerView)
        sideBarTableViewController.delegate = self
        sideBarTableViewController.tableView.frame = sideBarContainerView.bounds
        sideBarTableViewController.tableView.clipsToBounds = false
        sideBarTableViewController.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        sideBarTableViewController.tableView.backgroundColor = UIColor.clearColor()
        sideBarTableViewController.tableView.scrollsToTop = false
        sideBarTableViewController.tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0)
        
        sideBarContainerView.addSubview(sideBarTableViewController.tableView)
        
        self.menuButton.enabled = false
        let delay = 6.0 * Double(NSEC_PER_SEC)
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        dispatch_after(time, dispatch_get_main_queue(), {
            sideBarContainerView.removeFromSuperview()
            self.menuButton.enabled = true
            
        })
    }
    func SearchCity(sender: UIBarButtonItem) {
        searchCity!.viewModel = self.viewModel
        self.presentViewController(searchCity!, animated: true, completion: nil)
    }
    
    func pullToRefresh(sender:AnyObject){
        
        if self.locationLabel!.text! == "" {
            viewModel?.startLocationService()
        } else if self.locationLabel!.text! == "Current Location" || self.locationLabel!.text! == "" {
            locationService = LocationService()
            locationService.delegate = self
            locationService.requestLocation()
        } else {
            DataManager.getLocationFromGoogle(self.locationLabel!.text!, success: {(LocationData) -> Void in
                let json = JSON(data: LocationData)
                if json["status"] == "OK" {
                    let longitudeX = json["results"][0]["geometry"]["location"]["lng"].double!
                    let latitudeY = json["results"][0]["geometry"]["location"]["lat"].double!
                    let cityLocation: CLLocation =  CLLocation(latitude: latitudeY, longitude: longitudeX)
                    
                    dispatch_async(dispatch_get_main_queue()) {
                        self.viewModel?.searchCityLocation(self.locationLabel!.text!,location: cityLocation)
                    }
                } else {
                    dispatch_async(dispatch_get_main_queue()) {
                        let myAlert = UIAlertController(title: nil, message: "Address not found", preferredStyle: .Alert)
                        let action = UIAlertAction(
                            title: "OK",
                            style: .Default, handler: nil)
                        myAlert.addAction(action)
                        self.presentViewController(myAlert, animated: true, completion: nil)
                    }
                }
            })
        }
        let now = NSDate()
        let updateString = "Last Updated at " + self.dateFormatter.stringFromDate(now)
        self.refreshControl.attributedTitle = NSAttributedString(string: updateString)
        if self.refreshControl.refreshing {
        self.refreshControl.endRefreshing()
         
        }
    
    }
    
    func locationDidUpdate(service: LocationService, location: CLLocation) {
        
        // update "last updated" title for refresh control
        let now = NSDate()
        let updateString = "Last Updated at " + self.dateFormatter.stringFromDate(now)
        self.refreshControl.attributedTitle = NSAttributedString(string: updateString)
        
        if self.refreshControl.refreshing {
            self.refreshControl.endRefreshing()
            
        }
         viewModel?.refreshLocation(location)
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}








   

