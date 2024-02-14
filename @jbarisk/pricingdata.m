function [data, response] = pricingdata(c,risktype,vulnerabilityset,countryid,scenario,varargin)
%PRICINGDATA JBARisk pricing data.
%   [DATA,RESPONSE] = PRICINGDATA(C,RISKTYPE,VULNERABILITYSET,COUNTRYID,[],VARARGIN) 
%   returns pricing data given the RISKTYPE, VULNERABILTYSET, COUNTRYID and
%   the location specified in VARARGIN as a name value pair.   All are
%   input as string scalars or character vectors.
%
%   [DATA,RESPONSE] = PRICINGDATA(C,RISKTYPE,VULNERABILITYSET,COUNTRYID,SCENARIO,VARARGIN) 
%   returns pricing data given the RISKTYPE, VULNERABILTYSET, COUNTRYID, SCENARIO
%   the location specified in VARARGIN as a name value pair.   All are
%   input as string scalars or character vectors.
%
%   For example,
%
%   [data,response] = pricingdata(j,"R-GBL-X-X","Global","US5",[],"geometry","POINT(-101.65 43.45)")
%   
%   data =
%   
%     1x2 table
%   
%       id    pricing_data
%       __    ____________
%   
%       0      1x1 struct 
%   
%   
%   response = 
%   
%     ResponseMessage with properties:
%   
%       StatusLine: 'HTTP/1.1 200 OK'
%       StatusCode: OK
%           Header: [1x9 matlab.net.http.HeaderField]
%             Body: [1x1 matlab.net.http.MessageBody]
%     Completed: 0
%     
%     [data,response] = pricingdata(j,"R-GBL-X-X","Global","US5","rcp45_2016-2045","geometry","POINT(-101.65 43.45)")
%
%   returns
%
%   data =
%   
%     1x2 table
%   
%       id    pricing_data
%       __    ____________
%
%       0      1x1 struct
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
%   See also JBARISK.

%   Copyright 2023-2024 The MathWorks, Inc. 

% Create components for request
urlString = strcat(c.URL,"pricingdata/",risktype,"/",vulnerabilityset,"/",countryid);

% Add scenario if given
if exist("scenario","var") && ~isempty(scenario)
  urlString = strcat(urlString,"/scenario/",scenario);
end

% make request for data
if nargin < 6
  error("geometry parameter required.")
elseif isstruct(varargin{1}) || isscalar(varargin)
  [data, response] = makeRequest(c,urlString,varargin{1});
else
  [data, response] = makeRequest(c,urlString,[],varargin{:});
end