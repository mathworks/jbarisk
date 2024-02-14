function [data, response] = ccscenarios(c,id,varargin)
%CCSCENARIOS JBARisk climate change scenario information.
%   [DATA,RESPONSE] = CCSCENARIOS(C,COUNTRYID) returns information for a specific
%   climate change scenario.  ID is input as a scalar string or character vector.
%
%   [DATA,RESPONSE] = CCSCENARIOS(C,COUNTRYID,VARARGIN) 
%   returns climate change scenario information for a given country id.
%   Scenario, starting and ending time, and time filter are input as 
%   name/value pairs.  Inputs are scalar 
%   strings or character vectors.  TIMESTART is a starting year, TIMEEND is
%   ending year and TIMEFILTER is a range of years separated by "-".
%   
%   DATA is a table containing the requested data and RESPONSE is a
%   ResponseMessage containing all the request response information.
%
%   For example,
%
%   [data,response] = ccscenarios(c,"GB")
%
%   returns
%
%   data =
%   
%     3x2 table
%   
%         rcp45         rcp85   
%       __________    __________
%   
%       1x1 struct    1x1 struct
%       1x1 struct    1x1 struct
%       1x1 struct    1x1 struct
%   
%   
%   response = 
%   
%     ResponseMessage with properties:
%   
%       StatusLine: 'HTTP/1.1 200 OK'
%       StatusCode: OK
%           Header: [1x8 matlab.net.http.HeaderField]
%             Body: [1x1 matlab.net.http.MessageBody]
%        Completed: 0
%   
%   data = ccscenarios(c,"US5","scenario","rcp45","time_start","2020","time_end","2040","time_filter","2020-2040")
%
%   data =
%   
%     1x5 table
%   
%       index      startDate       country       endDate          id  
%       _____    ______________    _______    ______________    ______
%   
%       1.00     {'2007-12-01'}    {'USA'}    {'2009-07-01'}    116.00
%    
%   See also JBARISK.

%   Copyright 2023-2024 The MathWorks, Inc. 

% Create base URL string
urlString = strcat(c.URL,"ccscenarios/",string(id));

% make request for data, there is no POST option with message payload for
% the ccscenarios endpoint
if nargin < 3
  [data, response] = makeRequest(c,urlString);  
else
  [data, response] = makeRequest(c,urlString,[],varargin{:});
end