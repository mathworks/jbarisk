# Getting Started with JBA Risk in MATLAB&reg;

## Description

This interface allows users to access JBA Risk data directly from MATLAB.  JBA Risk provides flood maps, catastrophe models and analytics for the insurance, reinsurance, property management and government sectors for use in quantifying and mitigating flood risk.

[![Open in MATLAB Online](https://www.mathworks.com/images/responsive/global/open-in-matlab-online.svg)](https://matlab.mathworks.com/open/github/v1?repo=mathworks/Access_JBA_Risk_from_MATLAB)
## System Requirements

- MATLAB R2022a or later

## Features

Users can retrieve JBA Risk data directly from MATLAB.   More information can be found here:

https://www.jbarisk.com/

and additional documentation for the JBA Risk REST API is here:

https://flyvis-openapi.s3.eu-west-1.amazonaws.com/index.html#/

JBA Risk provides a token to establish a valid API connection for all requests.  Users can retrieve information required to make subsequent data requests given an URL endpoint and additional request parameters.

## Create a JBA Risk connection and set up JSON string and request structure for example requests.

```MATLAB
conn = jbarisk("token");
```
####  Create Request structure with two locations for the following examples.  The geometry is defined in WGS84 coordinates in these examples.
```MATLAB
reqStruct.country_code = "US5";
reqStruct.geometries(1).id = "point 1";
reqStruct.geometries(1).wkt_geometry = "POINT(-101.1412927159555553 43.94424115485919)";
reqStruct.geometries(1).buffer = 10;
reqStruct.geometries(2).id = "point 2";
reqStruct.geometries(2).wkt_geometry = "POINT(-102.1412927159555553 42.94424115485919)";
reqStruct.geometries(2).buffer = 10;
```
#### Create JSON string with on location for the following examples.
```MATLAB
jsonParams = '{"country_code": "US5","geometries": [{"id": "point 1","wkt_geometry": "POINT(-101.65 43.45)","buffer": 10}]}';
```

## Retrieve country information.    The returned information represents dataset identifiers of baseline maps.
```MATLAB
conn.HttpMethod = "GET";
[data,response] = countries(conn);
[data,response] = countries(conn,"US5");
[data,response] = countries(conn,"US5","geometry","POINT(-101.1412927159555553 43.94424115485919)","buffer","10");

conn.HttpMethod = "OPTIONS";
[data,response] = countries(conn);
[data,response] = countries(conn,"US5");
[data,response] = countries(conn,"US5","geometry","POINT(-101.1412927159555553 43.94424115485919)");

conn.HttpMethod = "POST";
[data,response] = countries(conn,"US5",jsonParams);
[data,response] = countries(conn,"US5",reqStruct);
```

## Retrieve cimate change scenarios for a specified dataset identifier.   The scenarios are representative concentration pathways.
```MATLAB
conn.HttpMethod = "GET";
[data,response] = ccscenarios(conn,"US5");
[data,response] = ccscenarios(conn,"US5","scenario","rcp45");
[data,response] = ccscenarios(conn,"US5","scenario","rcp45","time_start","2020","time_end","2040","time_filter","2020-2040");

conn.HttpMethod = "OPTIONS";
[data,response] = ccscenarios(conn,"US5");
[data,response] = ccscenarios(conn,"US5","scenario","rcp45");
```

## Retrieve flood depth information for specified dataset identifier and scenario.
```MATLAB
conn.HttpMethod = "GET";
[data,response] = flooddepths(conn,"US5");
[data,response] = flooddepths(conn,"US5",[]);
[data,response] = flooddepths(conn,"US5","rcp45_2016-2045");
[data,response] = flooddepths(conn,"US5",[],"geometry","POINT(-101.1412927159555553 43.94424115485919)","buffer","10");
[data,response] = flooddepths(conn,"US5","rcp45_2016-2045","geometry","POINT(-101.1412927159555553 43.94424115485919)","buffer","10");

conn.HttpMethod = "OPTIONS";
[data,response] = flooddepths(conn,"US5");
[data,response] = flooddepths(conn,"US5",[]);
[data,response] = flooddepths(conn,"US5","rcp45_2016-2045");
[data,response] = flooddepths(conn,"US5",[],"geometry","POINT(-101.1412927159555553 43.94424115485919)","buffer","10");
[data,response] = flooddepths(conn,"US5","rcp45_2016-2045","geometry","POINT(-101.1412927159555553 43.94424115485919)","buffer","10");

conn.HttpMethod = "POST";
[data,response] = flooddepths(conn,"US5",[],reqStruct);
[data,response] = flooddepths(conn,"US5",[],jsonParams);
[data,response] = flooddepths(conn,"US5","rcp45_2016-2045",reqStruct);
[data,response] = flooddepths(conn,"US5","rcp45_2016-2045",jsonParams);
```

## Retrieve calculated flood score information for a specified dataset identifier and scenario.
```MATLAB
conn.HttpMethod = "GET";
[data,response] = floodscores(conn,"US5");
[data,response] = floodscores(conn,"US5",[]);
[data,response] = floodscores(conn,"US5","rcp45_2016-2045");
[data,response] = floodscores(conn,"US5",[],"geometry","POINT(-101.1412927159555553 43.94424115485919)","buffer","10");
[data,response] = floodscores(conn,"US5","rcp45_2016-2045","geometry","POINT(-101.1412927159555553 43.94424115485919)","buffer","10");

conn.HttpMethod = "OPTIONS";
[data,response] = floodscores(conn,"US5");
[data,response] = floodscores(conn,"US5",[]);
[data,response] = floodscores(conn,"US5","rcp45_2016-2045");
[data,response] = floodscores(conn,"US5",[],"geometry","POINT(-101.1412927159555553 43.94424115485919)","buffer","10");
[data,response] = floodscores(conn,"US5","rcp45_2016-2045","geometry","POINT(-101.1412927159555553 43.94424115485919)","buffer","10");

conn.HttpMethod = "POST";
[data,response] = floodscores(conn,"US5",[],reqStruct);
[data,response] = floodscores(conn,"US5",[],jsonParams);
[data,response] = floodscores(conn,"US5","rcp45_2016-2045",reqStruct);
[data,response] = floodscores(conn,"US5","rcp45_2016-2045",jsonParams);
```

## Retrieve calculated pricing data for a specific vulnerabilty curve given a region and dataset identifier.
```MATLAB
conn.HttpMethod = "GET";
[data,response] = pricingdata(conn,"R-GBL-X-X","Global","US5",[],"geometry","POINT(-101.65 43.45)");
[data,response] = pricingdata(conn,"R-GBL-X-X","Global","US5","rcp45_2016-2045","geometry","POINT(-101.65 43.45)");

conn.HttpMethod = "OPTIONS";
[data,response] = pricingdata(conn,"R-GBL-X-X","Global","US5",[],"geometry","POINT(-101.65 43.45)");
[data,response] = pricingdata(conn,"R-GBL-X-X","Global","US5","rcp45_2016-2045","geometry","POINT(-101.65 43.45)");
            
conn.HttpMethod = "POST";
[data,response] = pricingdata(conn,"R-GBL-X-X","Global","US5",[],reqStruct);
[data,response] = pricingdata(conn,"R-GBL-X-X","Global","US5","rcp45_2016-2045",reqStruct);
[data,response] = pricingdata(conn,"R-GBL-X-X","Global","US5",[],jsonParams);
[data,response] = pricingdata(conn,"R-GBL-X-X","Global","US5","rcp45_2016-2045",jsonParams);
```

## Retrieve a list of vulnerability curves for pricing data calculations for a specified region.
```MATLAB
conn.HttpMethod = "GET";
[data,response] = risktypes(conn,"UK");

conn.HttpMethod = "OPTIONS";
[data,response] = risktypes(conn,"UK");
```

## Retrieve a list of regions with available vulnerability curves.
```MATLAB
conn.HttpMethod = "GET";
[data,response] = vulnerabilitycurveregions(conn);

conn.HttpMethod = "OPTIONS";
[data,response] = vulnerabilitycurveregions(conn);
```
## License

The license is available in the LICENSE.TXT file in this GitHub repository.

Community Support

MATLAB Central

Copyright 2024 The MathWorks, Inc.