//
//  WeatherViewController.swift
//  WeatherApp
//
//  Created by Jun Dang on 16/1/23.
//  Copyright © 2016年 Jun Dang. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController , UIScrollViewDelegate, UITableViewDelegate, UINavigationBarDelegate {
    
    var BackgroundScrollView: UIScrollView!
    var ForegroundScrollView: UIScrollView!
    //var horizontalScrollView: UIScrollView!
    var backgroundImageView: UIImageView!
    var screenHeight: CGFloat!
    var blurredImageView: UIImageView!
    var collectionView1: UICollectionView!
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
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //background
        
        self.view.backgroundColor = UIColor.blackColor()
        //let screenSize: CGRect = UIScreen.mainScreen().bounds
        screenHeight = screenSize.height
        backgroundImageView = UIImageView(image: UIImage(named: "bg"))
        backgroundImageView?.contentMode = UIViewContentMode.ScaleAspectFill
        //backgroundImageView?.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: screenHeight)
        backgroundImageView?.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: screenHeight*2)
        backgroundImageView!.setNeedsDisplay()
        
        
        //add background ScrollView
        
        BackgroundScrollView = UIScrollView(frame: view.bounds)
        BackgroundScrollView.backgroundColor = UIColor.clearColor()
        BackgroundScrollView.contentSize = backgroundImageView.bounds.size
        BackgroundScrollView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        BackgroundScrollView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        BackgroundScrollView.addSubview(backgroundImageView!)
        
        //blur image view
        
        blurredImageView = UIImageView(image: UIImage(named: "bg"))
        blurredImageView?.contentMode = UIViewContentMode.ScaleAspectFill
        blurredImageView?.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: screenHeight*2)
        //blurredImageView?.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: screenHeight)
        blurredImageView!.alpha = 0
        blurredImageView?.setImageToBlur(UIImage(named: "bg"), blurRadius: 10, completionBlock: nil)
        blurredImageView.translatesAutoresizingMaskIntoConstraints = false
        blurredImageView!.setNeedsDisplay()
        BackgroundScrollView.addSubview(blurredImageView)
        view.addSubview(BackgroundScrollView)
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
        
        //containerView
        let containerSize1 = CGSize(width: view.bounds.width, height: screenHeight)
        containerView1 = UIView(frame: CGRect(origin: CGPoint(x: 0, y: screenHeight + 15), size:containerSize1))
        containerView1?.backgroundColor = UIColor.clearColor()
        containerView1!.setNeedsDisplay()
        containerView1!.translatesAutoresizingMaskIntoConstraints = false
        let fheight1 = containerView1?.frame.height
        //let cheight2 = fheight1! + screenHeight + 10
       
        let containerSize2 = CGSize(width: view.bounds.width, height: screenHeight)
        containerView2 = UIView(frame: CGRect(origin: CGPoint(x: 0, y: screenHeight + 5), size:containerSize2))
        containerView2?.backgroundColor = UIColor.clearColor()
        containerView2!.setNeedsDisplay()
        containerView2!.translatesAutoresizingMaskIntoConstraints = false
        //let fheight2 = containerView2?.frame.height
        let containerSize3 = CGSize(width: view.bounds.width, height: screenHeight)
        containerView3 = UIView(frame: CGRect(origin: CGPoint(x: 0, y: screenHeight + 5), size:containerSize3))
        containerView3?.backgroundColor = UIColor.clearColor()
        containerView3!.setNeedsDisplay()
        containerView3!.translatesAutoresizingMaskIntoConstraints = false
       // let fheight3 = containerView3?.frame.height
        let containerSize4 = CGSize(width: view.bounds.width, height: screenHeight)
        containerView4 = UIView(frame: CGRect(origin: CGPoint(x: 0, y: screenHeight + 5), size:containerSize4))
        containerView4?.backgroundColor = UIColor.clearColor()
        containerView4!.setNeedsDisplay()
        containerView4!.translatesAutoresizingMaskIntoConstraints = false

       //add mask to backgroundScrollView
        let maskLayer = CALayer()
        maskLayer.frame = screenSize
        //maskLayer.contents = UIImage(named: "bg")?.CGImage
        maskLayer.contentsGravity = kCAGravityCenter
        maskLayer.backgroundColor = UIColor.blackColor().CGColor
        maskLayer.opacity = 0.2
        maskLayer.hidden = false
        maskLayer.masksToBounds = false
        BackgroundScrollView.layer.addSublayer(maskLayer)
        

        // ForegroundScrollView
        
        ForegroundScrollView = UIScrollView(frame: view.bounds)
        ForegroundScrollView.backgroundColor = UIColor.clearColor()
        //let fheight2 = containerView2?.frame.height
       // let foreHeight = fheight1! + fheight2! + screenHeight + 50
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
      
        //let weatherTableViewController: WeatherTableViewController = WeatherTableViewController()
        
        //add location label
        locationLabel = UILabel(frame: CGRectMake(screenWidth/2-60, 20, 100, 60))
        let fontLocation = UIFont(name: "HelveticaNeue-Bold", size: 20.0)
        locationLabel!.font = fontLocation
        locationLabel!.backgroundColor = UIColor.clearColor()
        locationLabel!.textColor = UIColor.whiteColor()
        locationLabel!.textAlignment = NSTextAlignment.Center
        ForegroundScrollView.addSubview(locationLabel!)
        
        //add temperature label
        temperatureLabel = UILabel(frame: CGRectMake(13, screenHeight-130, 200, 200))
        let fontTemperatureLabel = UIFont(name: "HelveticaNeue", size: 80.0)
        temperatureLabel!.font = fontTemperatureLabel
        temperatureLabel!.backgroundColor = UIColor.clearColor()
        temperatureLabel!.textColor = UIColor.whiteColor()
        temperatureLabel!.text = "20\u{00B0}"
        ForegroundScrollView.addSubview(temperatureLabel!)
        
        //add minute summary
        minutelySummary = UILabel(frame: CGRectMake(130, screenHeight-50, 300, 80))
        let fontLabel = UIFont(name: "HelveticaNeue-Bold", size: 13.0)
        minutelySummary!.font = fontLabel
        minutelySummary!.backgroundColor = UIColor.clearColor()
        minutelySummary!.textColor = UIColor.whiteColor()
      
        ForegroundScrollView.addSubview(minutelySummary!)
        

        /*//up arrow
        let upArrow = UIImageView(frame: CGRectMake(13, screenHeight-90, 25, 25))
        upArrow.image = UIImage(named: "Up-25")
        self.ForegroundScrollView.addSubview(upArrow)*/
        
        //max temperature description
        let maxTemperature = UILabel(frame: CGRectMake(70, screenHeight-117, 80, 80))
        maxTemperature.backgroundColor = UIColor.clearColor()
        maxTemperature.textColor = UIColor.whiteColor()
        maxTemperature.text = "High:"
        maxTemperature.font = UIFont(name: "HelveticaNeue-Bold", size: 10)
        self.ForegroundScrollView.addSubview(maxTemperature)

        //low temperature label
        lowLabel = UILabel(frame: CGRectMake(37, screenHeight-117, 80, 80))
        lowLabel!.backgroundColor = UIColor.clearColor()
        lowLabel!.textColor = UIColor.whiteColor()
        lowLabel!.text = "20\u{00B0}"
        lowLabel!.font = UIFont(name: "HelveticaNeue-Bold", size: 15)
        ForegroundScrollView.addSubview(lowLabel!)
        
        /*//Down arrow
        let downArrow = UIImageView(frame: CGRectMake(60, screenHeight-90, 25, 25))
        downArrow.image = UIImage(named: "Down-25")
        self.ForegroundScrollView.addSubview(downArrow)*/
        
        //min temperature description
        let minTemperature = UILabel(frame: CGRectMake(12, screenHeight-117, 80, 80))
        minTemperature.backgroundColor = UIColor.clearColor()
        minTemperature.textColor = UIColor.whiteColor()
        minTemperature.text = "Low:"
        minTemperature.font = UIFont(name: "HelveticaNeue-Bold", size: 10)
        self.ForegroundScrollView.addSubview(minTemperature)
     
        //high temperature label
        hiLabel = UILabel(frame: CGRectMake(97, screenHeight-117, 80, 80))
        hiLabel!.backgroundColor = UIColor.clearColor()
        hiLabel!.textColor = UIColor.whiteColor()
        //lowLabel!.text = "20\u{00B0}"
        hiLabel!.font = UIFont(name: "HelveticaNeue-Bold", size: 15)
        self.ForegroundScrollView.addSubview(hiLabel!)
        
        //Feels like
        
        let feelsLike = UILabel(frame: CGRectMake(128, screenHeight-117, 80, 80))
        feelsLike.backgroundColor = UIColor.clearColor()
        feelsLike.textColor = UIColor.whiteColor()
        feelsLike.text = "Feels like:"
        feelsLike.font = UIFont(name: "HelveticaNeue-Bold", size: 10)
        self.ForegroundScrollView.addSubview(feelsLike)
        
        //FeelsLikeTemperature
        feelsLikeTemperature = UILabel(frame: CGRectMake(179, screenHeight-117, 80, 80))
        feelsLikeTemperature!.backgroundColor = UIColor.clearColor()
        feelsLikeTemperature!.textColor = UIColor.whiteColor()
        feelsLikeTemperature!.font = UIFont(name: "HelveticaNeue-Bold", size: 15)
        self.ForegroundScrollView.addSubview(feelsLikeTemperature!)

        //weathericon2Label
        weathericon2Label = UILabel(frame: CGRectMake(13, screenHeight-120, 30, 30))
        weathericon2Label!.backgroundColor = UIColor.clearColor()
        weathericon2Label!.textColor = UIColor.clearColor()
        //weathericon2Label!.text = "weather-clear"
        weathericon2Label!.hidden = true
        
        //weathericon2
        weathericon2 = UIImageView(frame: CGRectMake(13, screenHeight-120, 30, 30))
        weathericon2!.image = UIImage(named: "weather-clear")
       // print(weathericon2Label!.text)
       // weathericon2!.image = UIImage(named: "\(weathericon2Label!.text)")
        self.ForegroundScrollView.addSubview(weathericon2!)
        //add weather description
        weatherDescription = UILabel(frame: CGRectMake(50, screenHeight-150, 200, 100))
        weatherDescription!.backgroundColor = UIColor.clearColor()
        weatherDescription!.textColor = UIColor.whiteColor()
        weatherDescription!.font = UIFont(name: "HelveticaNeue-Bold", size: 15)
        self.ForegroundScrollView.addSubview(weatherDescription!)
        //add segmented controll
        // Initialize
        let items = ["Table", "Graph", "Summary", "Air Quality"]
        let segmentedControll = UISegmentedControl(items: items)
        segmentedControll.selectedSegmentIndex = 0
        segmentedControll.frame = CGRectMake(screenSize.minX + 10, screenHeight + 5,
            screenSize.width - 20, screenSize.height*0.05)
        segmentedControll.layer.cornerRadius = 5.0  // Don't let background bleed
        segmentedControll.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.2)
        segmentedControll.tintColor = UIColor.whiteColor()
        segmentedControll.addTarget(self, action: "changeDisplay:", forControlEvents: .ValueChanged)
        self.ForegroundScrollView.addSubview(segmentedControll)
        weatherTableViewController = WeatherTableViewController()
        forecastGraphs = Graphs()
        forecastSummary = Summary()
        airQuality = AirQuality()
        displayContentController(weatherTableViewController!)
        displayGraphs(forecastGraphs!)
        displaySummary(forecastSummary!)
        displayAirQuality(airQuality!)

        viewModel = WeatherViewModel()
        viewModel?.startLocationService()
        print(screenSize)
        //add navigation bar
        let navigationBar = UINavigationBar(frame: CGRectMake(0, 33, self.view.frame.size.width, 40))
        navigationBar.backgroundColor = UIColor.clearColor()
        navigationBar.tintColor = UIColor.whiteColor()
        //navigationBar.translucent = true
        navigationBar.delegate = self
        let navigationItem = UINavigationItem()
        let searchButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Search, target: self, action: "SearchCity:")
        let menuButton = UIButton()
        //set image for button
        menuButton.frame = CGRectMake(20, 35, 35, 35)
        menuButton.setImage(UIImage(named: "icon-menu-narrow-white"), forState: .Normal)
        menuButton.addTarget(self, action: Selector("menuButtonPressed"), forControlEvents: .TouchUpInside)
        //assign button to navigationbar
        let menubarButton = UIBarButtonItem(customView: menuButton)
        
        navigationItem.leftBarButtonItem = menubarButton
        //let settingButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Action, target: self, action: "Settings:")
        navigationItem.rightBarButtonItem = searchButton
        //navigationItem.leftBarButtonItem = settingButton
        
        // Assign the navigation item to the navigation bar
        navigationBar.items = [navigationItem]
        
        // Make the navigation bar a subview of the current view controller
        
        self.ForegroundScrollView.addSubview(navigationBar)
        
        searchCity = SearchCityViewController()
        
        
    }

       override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
        
        
        
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
        print("change display handler is called.")
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
            containerView2!.frame.size.height = forecastGraphs.view.frame.height
            containerView2!.frame.size.width = forecastGraphs.view.frame.width
            self.addChildViewController(forecastGraphs)
            self.containerView2!.addSubview(forecastGraphs.view)
            forecastGraphs.didMoveToParentViewController(self)
            self.forecastGraphs = forecastGraphs
            
        }
    func displaySummary(forecastSummary: Summary) {
            containerView3!.frame.size.height = forecastSummary.view.frame.height
            containerView3!.frame.size.width = forecastSummary.view.frame.width
            self.addChildViewController(forecastSummary)
            self.containerView3!.addSubview(forecastSummary.view)
            forecastSummary.didMoveToParentViewController(self)
            self.forecastSummary = forecastSummary
            
        }
    func displayAirQuality(airQuality: AirQuality) {
            containerView4!.frame.size.height = airQuality.view.frame.height
            containerView4!.frame.size.width = airQuality.view.frame.width
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
                   //self.weatherDescription!.text = "\(self.weathericon2Label!.text!)"

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
                            print("calledImage")
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
           /* viewModel?.precipitationType.observe {
                [unowned self] in
                self.forecastSummary!.precipType!.text = $0
            }*/
            viewModel?.dewPoint.observe {
                [unowned self] in
                self.forecastSummary!.dewPoint!.text = $0
            }
            viewModel?.humidity.observe {
                [unowned self] in
                self.forecastSummary!.humidity!.text = $0
            }
            /*viewModel?.windDirection.observe {
                [unowned self] in
                self.forecastSummary!.windDirection!.text = $0
            }*/
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
           /* viewModel?.weeklySummary.observe {
                [unowned self] in
                self.forecastSummary!.weeklySummary!.text = $0
            }*/
            viewModel?.dailyForecasts.observe {
                [unowned self] in
                //print($0.count)
                self.weatherTableViewController!.updateDailyData($0)
                
            }
            viewModel?.hourlyForecasts.observe {
                [unowned self] in
                self.weatherTableViewController!.updateHourlyData($0)
                self.forecastGraphs!.updateHourlyData($0)
                
            }
        }
    }
    
    func menuButtonPressed() {
        
        print("menuButtonPressed")
    }
    func SearchCity(sender: UIBarButtonItem) {
        self.presentViewController(searchCity!, animated: true, completion: nil)
    }
}
   

