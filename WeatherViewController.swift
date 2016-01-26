//
//  WeatherViewController.swift
//  WeatherApp
//
//  Created by Yuan Yinhuan on 16/1/23.
//  Copyright © 2016年 Jun Jun. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController , UIScrollViewDelegate, UITableViewDelegate {
    
    var BackgroundScrollView: UIScrollView!
    var ForegroundScrollView: UIScrollView!
    var horizontalScrollView: UIScrollView!
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
    var hiLabel: UILabel?
    var lowLabel: UILabel?
    var weathericon2: UIImageView?
    var weathericon2Label: UILabel?
    var weatherDescription: UILabel?
    var weatherTableViewController: WeatherTableViewController?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //background
        
        self.view.backgroundColor = UIColor.redColor()
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        screenHeight = screenSize.height
        backgroundImageView = UIImageView(image: UIImage(named: "bg"))
        backgroundImageView?.contentMode = UIViewContentMode.ScaleAspectFill
        backgroundImageView?.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: screenHeight*3)
        
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
        blurredImageView?.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: screenHeight*3)
        blurredImageView!.alpha = 0
        blurredImageView?.setImageToBlur(UIImage(named: "bg"), blurRadius: 10, completionBlock: nil)
        blurredImageView.translatesAutoresizingMaskIntoConstraints = false
        BackgroundScrollView.addSubview(blurredImageView)
        view.addSubview(BackgroundScrollView)
        
        let heightBScrollView = NSLayoutConstraint(item: BackgroundScrollView,
            attribute: .Height, relatedBy: .Equal, toItem: self.view,
            attribute: .Height, multiplier: 1, constant: 0)
        let widthBScrollView = NSLayoutConstraint(item: BackgroundScrollView,
            attribute: .Width, relatedBy: .Equal, toItem: self.view,
            attribute: .Width, multiplier: 1, constant: 0)
        NSLayoutConstraint.activateConstraints([heightBScrollView, widthBScrollView])
        
        let heightBImageView = NSLayoutConstraint(item: backgroundImageView,
            attribute: .Height, relatedBy: .Equal, toItem: BackgroundScrollView,
            attribute: .Height, multiplier: 1, constant: screenHeight*2)
        let widthBImageView = NSLayoutConstraint(item: backgroundImageView,
            attribute: .Width, relatedBy: .Equal, toItem: BackgroundScrollView,
            attribute: .Width, multiplier: 1, constant: 0)
        NSLayoutConstraint.activateConstraints([heightBImageView, widthBImageView])
        
        let heightBlurredImageView = NSLayoutConstraint(item: blurredImageView,
            attribute: .Height, relatedBy: .Equal, toItem: BackgroundScrollView,
            attribute: .Height, multiplier: 1, constant: screenHeight*2)
        
        let widthBlurredImageView = NSLayoutConstraint(item: blurredImageView,
            attribute: .Width, relatedBy: .Equal, toItem: BackgroundScrollView,
            attribute: .Width, multiplier: 1, constant: 0)
        NSLayoutConstraint.activateConstraints([heightBlurredImageView, widthBlurredImageView])
        
        //containerView
        let containerSize1 = CGSize(width: view.bounds.width, height: screenHeight)
        containerView1 = UIView(frame: CGRect(origin: CGPoint(x: 0, y: screenHeight), size:containerSize1))
        containerView1?.backgroundColor = UIColor.blueColor()
        containerView1!.setNeedsDisplay()
        containerView1!.translatesAutoresizingMaskIntoConstraints = false
        let fheight1 = containerView1?.frame.height
        let cheight2 = fheight1! + screenHeight + 10
       
        let containerSize2 = CGSize(width: view.bounds.width, height: screenHeight+300)
        containerView2 = UIView(frame: CGRect(origin: CGPoint(x: 0, y: cheight2), size:containerSize2))
        containerView2?.backgroundColor = UIColor.clearColor()
        
        // ForegroundScrollView
        
        ForegroundScrollView = UIScrollView(frame: view.bounds)
        ForegroundScrollView.backgroundColor = UIColor.clearColor()
        let fheight2 = containerView2?.frame.height
        let foreHeight = fheight1! + fheight2! + screenHeight + 50
        ForegroundScrollView.contentSize = CGSize(width: screenWidth, height: foreHeight)
        ForegroundScrollView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        ForegroundScrollView.translatesAutoresizingMaskIntoConstraints = false
        ForegroundScrollView.addSubview(containerView1!)
        ForegroundScrollView.addSubview(containerView2!)
        view.addSubview(ForegroundScrollView)
        
        ForegroundScrollView.delegate = self
        
        let heightForegroundScrollView = NSLayoutConstraint(item: ForegroundScrollView,
            attribute: .Height, relatedBy: .Equal, toItem: BackgroundScrollView,
            attribute: .Height, multiplier: 1, constant: 0)
        let widthForegroundScrollView = NSLayoutConstraint(item: ForegroundScrollView,
            attribute: .Width, relatedBy: .Equal, toItem: BackgroundScrollView,
            attribute: .Width, multiplier: 1, constant: 0)
        NSLayoutConstraint.activateConstraints([heightForegroundScrollView, widthForegroundScrollView])
      
        let weatherTableViewController: WeatherTableViewController = WeatherTableViewController()
        displayContentController(weatherTableViewController)
        
        //add location label
        locationLabel = UILabel(frame: CGRectMake(150, 50, 100, 60))
        let fontLocation = UIFont(name: "Arial", size: 20.0)
        locationLabel!.font = fontLocation
        locationLabel!.backgroundColor = UIColor.blueColor()
        locationLabel!.textColor = UIColor.redColor()
        locationLabel!.textAlignment = NSTextAlignment.Center
        ForegroundScrollView.addSubview(locationLabel!)
        
        //add temperature label
        temperatureLabel = UILabel(frame: CGRectMake(13, screenHeight-130, 200, 200))
        let fontTemperatureLabel = UIFont(name: "Arial", size: 80.0)
        temperatureLabel!.font = fontTemperatureLabel
        temperatureLabel!.backgroundColor = UIColor.clearColor()
        temperatureLabel!.textColor = UIColor.redColor()
        temperatureLabel!.text = "20\u{00B0}"
        ForegroundScrollView.addSubview(temperatureLabel!)
        
        //up arrow
        let upArrow = UIImageView(frame: CGRectMake(13, screenHeight-90, 25, 25))
        upArrow.image = UIImage(named: "Up-25")
        self.ForegroundScrollView.addSubview(upArrow)
        
        //high temperature label
        hiLabel = UILabel(frame: CGRectMake(34, screenHeight-117, 80, 80))
        hiLabel!.backgroundColor = UIColor.clearColor()
        hiLabel!.textColor = UIColor.blackColor()
        hiLabel!.text = "20\u{00B0}"
        hiLabel!.font = UIFont(name: "HelveticaNeue-UltraLight", size: 15)
        ForegroundScrollView.addSubview(hiLabel!)
        
        //Down arrow
        let downArrow = UIImageView(frame: CGRectMake(60, screenHeight-90, 25, 25))
        downArrow.image = UIImage(named: "Down-25")
        self.ForegroundScrollView.addSubview(downArrow)
        
        //low temperature label
        lowLabel = UILabel(frame: CGRectMake(80, screenHeight-117, 80, 80))
        lowLabel!.backgroundColor = UIColor.clearColor()
        lowLabel!.textColor = UIColor.blackColor()
        //lowLabel!.text = "20\u{00B0}"
        lowLabel!.font = UIFont(name: "HelveticaNeue-UltraLight", size: 15)
        self.ForegroundScrollView.addSubview(lowLabel!)
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
        weatherDescription!.textColor = UIColor.blackColor()
        weatherDescription!.font = UIFont(name: "HelveticaNeue-UltraLight", size: 15)
        
        
        self.ForegroundScrollView.addSubview(weatherDescription!)
        
        //WeatherDataService().retrieveWeatherInfo(43.7000, longitude: -79.4000)
        /* let newYork = CLLocation(latitude: 40.7127, longitude: -74.0059)
        WeatherService().retrieveWeatherInfo(newYork) { (weather, error) -> Void in
        dispatch_async(dispatch_get_main_queue(), {
        print("Hello world")
        /*
        if let unwrappedError = error {
        print(unwrappedError)
        self.update(unwrappedError)
        return
        }
        
        guard let unwrappedWeather = weather else {
        return
        }
        self.update(unwrappedWeather)*/
        })
        }*/
        viewModel = WeatherViewModel()
        viewModel?.startLocationService()
        
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
    
    func displayContentController(weatherTableViewController: WeatherTableViewController) {
        
        containerView1!.frame.size.height = weatherTableViewController.tableView.frame.height
        containerView1!.frame.size.width = weatherTableViewController.tableView.frame.width
        self.addChildViewController(weatherTableViewController)
        self.containerView1!.addSubview(weatherTableViewController.tableView)
        weatherTableViewController.didMoveToParentViewController(self)
        self.weatherTableViewController = weatherTableViewController
        
    }
    
    // MARK: ViewModel
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
                   self.weatherDescription!.text = "\(self.weathericon2Label!.text!)"
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
            
            viewModel?.dailyForecasts.observe {
                [unowned self] in
                //print($0.count)
                self.weatherTableViewController!.updateDailyData($0)
                
            }
            viewModel?.hourlyForecasts.observe {
                [unowned self] in
                self.weatherTableViewController!.updateHourlyData($0)
                
            }
        }
    }

    
   }