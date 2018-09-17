//
//  TestJSON.swift
//  AstronomyTests
//
//  Created by Samantha Gatt on 9/17/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import Foundation

let testRoverJSON = """
{"photo_manifest":{"name":"Curiosity","landing_date":"2012-08-06","launch_date":"2011-11-26","status":"active","max_sol":2172,"max_date":"2018-09-15","total_photos":341463,"photos":[{"sol":0,"earth_date":"2012-08-06","total_photos":3702,"cameras":["CHEMCAM","FHAZ","MARDI","RHAZ"]}]}}
""".data(using: .utf8)


let testPhotoJSON = """
{"photos":[{"id":727,"sol":0,"camera":{"id":20,"name":"FHAZ","rover_id":5,"full_name":"Front Hazard Avoidance Camera"},"img_src":"http://mars.jpl.nasa.gov/msl-raw-images/proj/msl/redops/ods/surface/sol/00000/opgs/edr/fcam/FRA_397502305EDR_D0010000AUT_04096M_.JPG","earth_date":"2012-08-06","rover":{"id":5,"name":"Curiosity","landing_date":"2012-08-06","launch_date":"2011-11-26","status":"active","max_sol":2172,"max_date":"2018-09-15","total_photos":341463,"cameras":[{"name":"FHAZ","full_name":"Front Hazard Avoidance Camera"},{"name":"NAVCAM","full_name":"Navigation Camera"},{"name":"MAST","full_name":"Mast Camera"},{"name":"CHEMCAM","full_name":"Chemistry and Camera Complex"},{"name":"MAHLI","full_name":"Mars Hand Lens Imager"},{"name":"MARDI","full_name":"Mars Descent Imager"},{"name":"RHAZ","full_name":"Rear Hazard Avoidance Camera"}]}}]}
""".data(using: .utf8)!
