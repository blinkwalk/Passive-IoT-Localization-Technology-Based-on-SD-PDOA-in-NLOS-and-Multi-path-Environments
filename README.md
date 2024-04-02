# Passive-IoT-Localization-Technology-Based-on-SD-PDOA-in-NLOS-and-Multi-path-Environments
Reference source code for the paper “Passive IoT Localization Technology Based on SD-PDOA in NLOS and Multi-path Environments”

## Simulation Steps for Non-Line-of-Sight (NLOS) Passive Localization Techniques

1. Construct a simulation environment for NLOS, generate phase data, and call the `Func_SD_PDOA` function to calculate distances based on phase differences in spatial domain.
2. Utilize the ranging results, call the `Fun_LOCATION_CAL` function, compute hyperbolic location results in space, and filter according to specific criteria.
3. Incorporate the location results into an improved Kalman filter using the `Func_BiasedKalmanFilter` function to enhance localization accuracy.
4. Employ the `Fun_RMSE` function to compute the root mean square error (RMSE) value for evaluating localization precision.

## Simulation Steps for Multipath Environment in Passive Localization Techniques

1. Generate Received Signal Strength Indication (RSSI) data, utilize the `Fun_RSSI_Distance` function to calculate distances based on RSSI attenuation values.
2. Utilize the ranging results, call the `Func_Triangle_Cal` function to perform triangulation for obtaining localization results based on RSSI.
3. Incorporate the RSSI triangulation results into an improved Kalman filter using the `Func_BiasedKalmanFilter` function.
4. Export the RSSI-based localization results and generate confidence ellipses using Origin plotting software to delineate the localization area.
5. Simultaneously employ SD-PDOA localization by calling the `Func_SD_PDOA` function, calculate distances based on phase differences in spatial domain, utilize the ranging results, and call the `Fun_LOCATION_CAL` function to compute hyperbolic location results.
6. Determine whether the SD-PDOA localization results fall within the ellipse area, retain localization results falling within the area, and discard those outside the area.
7. Average the filtered SD-PDOA localization results to obtain the final localization result.
8. Utilize the `Fun_RMSE` function to compute the RMSE value for assessing localization accuracy.

Through the aforementioned algorithm steps, gather data from real-world environments, conduct testing and validation, and include relevant experimental data in the "Experimental Data" folder.
