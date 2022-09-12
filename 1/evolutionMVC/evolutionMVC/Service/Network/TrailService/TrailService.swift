//
//  TrailService.swift
//  evolutionMVC
//
//  Created by Vajda Kristóf on 2022. 09. 12..
//

/// Trail MicroService representation at client-side for handling requests and their responses
protocol TrailService {
    /**
     Fetches all trails that is available regardless count of list. For providing asynchronous communication, the result signaling back by completionBlock
     - *In case of success*: Gives back a list of Trail NetworkModel objects
     - *In case of failure*: Passes the error from response
     */
    func getTrails(
        completionBlock: @escaping (Result<[NetworkModel.Trail], TrailServiceError>) -> ()
    )
    
    /**
     Fetches only one trail with detail, based on its id. For providing asynchronous communication, the result signaling back by completionBlock
     - *In case of success*: Gives back the particular Trail NetworkModel object
     - *In case of failure*: Passes the error from response
     */
    func getTrail(
        by id: String,
        completionBlock: @escaping (Result<NetworkModel.Trail, TrailServiceError>) -> ()
    )
}
