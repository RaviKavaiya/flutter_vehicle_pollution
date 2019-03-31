# flutter_vehicle_pollution

A Flutter application that calculates CO2 emission of vehicles and tells whether you need to take care

This is a basic Flutter Application, which calculates your vehicle's CO2 emission in a year...

## How to use

- Run the application
- Provide the asked details
  - Select the type of the fuel of your vehicle
  - Enter how many kilometers the vehicle was driven last whole year
  - Enter mileage (kilometers / unit of fuel)
  - At last, provide no. of people that share this vehicle(drive OR use this vehicle)
- Now click on Calculate. It will show you your CO2 emission in the past year of your selected fuel.

- NOTE : In kilometers, give TOTAL kilometers the vehicle was driven, (NOT only by you, by all the people that share it)

- The program will use the given values along with the parameters of the fuel, and give CO2 emission (in tonnes) by each person that share that vehicle.

- It will show an animated green checkmark if you have done less pollution, otherwise will show a red cross mark.

## Features

- Google's material design components
- Supports both orientations: ListView in portrait, GridView in horizontal
- Form validations
- Flare animations for low and high pollutions
- Supported fuels: Diesel, Petrol, CNG, LPG
- Most important, the .dart source code is **less than 5KB!** (Only 5104 bytes)

##
## Credits

- [App icon and Splash screen icon](https://www.flaticon.com/free-icon/co2_1280979#term=car%20co2&page=1&position=20)
- [Background image](https://smedia2.intoday.in/btmt/images/stories/pollution_660_072418053541.jpg)
- [Population data](http://www.worldometers.info/world-population/)
- [Population data](https://www.prb.org/2018-world-population-data-sheet-with-focus-on-changing-age-structures/)
- [Worldwide pollution data](https://www.scientificamerican.com/article/co2-emissions-reached-an-all-time-high-in-2018/)
- Most important: [How I calculated the CO2 emission](http://ecoscore.be/en/info/ecoscore/co2)

## Notes

- For constructing the formula, I took the world's population as **37.1 billion** people in the year 2018
- And I took **7.6 billion ton** CO2 emission globally in the year 2018 by all vehicles
- So, we can take **4.8816** ton CO2 emitted per person in 2018 *(approx.)*


# Troubleshooting

- This was developed on Windows system. But when I tried to open this project in macOS and vice versa, it gave me an error.
- As a workaround, delete the '.packages' file in the project directory(it will be a hidden file) to get it working
- Another bug I faced was in flare_flutter package. It was not animating, just displaying. As a workaround, delete the flare_dart and flare_flutter packages in the flutter's cache (in system, not the project) and re-run the project




