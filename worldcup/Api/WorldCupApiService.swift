import Alamofire

class Api {
    typealias CommonParams = [String:String]
    
    let base: String
    
    init(base: String) {
        self.base = base
    }
    
    func get(endpoint: String = "", params: Parameters? = [:]) -> DataRequest {
        return Alamofire.request("\(base)/\(endpoint)", method: .get, parameters: params)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
    }
}

typealias JSON = [String: AnyObject]

struct Goal {
    let player: String
    let minute: Int
    
    init(player: String, minute: Int) {
        self.player = player
        self.minute = minute
    }
}

struct MatchResult {
    typealias Player = String
    typealias Minute = Int
    
    let team: String
    let goals: [Goal]
    var nGoals: Int {
        get {return self.goals.count}
    }
    
    init(team: String, teamEvents: [JSON]?) {
        self.team = team
        self.goals = (teamEvents ?? []).filter({
            $0["type_of_event"] as? String == "goal"
        }).map({
            let timeString = $0["time"] as! String
            let timeInt = Int(timeString.prefix(timeString.count - 1)) ?? 0
            return Goal(player: $0["player"] as! Player, minute: timeInt)
        })
    }
}

struct Match {
    
    let homeResult: MatchResult
    let awayResult: MatchResult
    
    init(json: JSON) {
        self.homeResult = MatchResult(
            team: json["home_team_country"]! as? String ?? "none",
            teamEvents: json["home_team_events"] as? [JSON])
        self.awayResult = MatchResult(
            team: json["away_team_country"]! as? String ?? "none",
            teamEvents: json["away_team_events"] as? [JSON])
    }
}

class WorldCupService {
    static let BASE_URL = "https://worldcup.sfg.io"
    static let JSON_KEY_DATE = "by_date"
    private let api: Api
    
    init() {
        self.api = Api(base: WorldCupService.BASE_URL)
    }

    func getMatches(onSuccess: @escaping ([Match]) -> Void, onFailure: @escaping (Error) -> Void) {
        self.api.get(
            endpoint: "matches",
            params: [WorldCupService.JSON_KEY_DATE: "desc"]).responseJSON(
                completionHandler: { response in
            switch (response.result) {
            case .success(let json):
                let jsonList = (json as! [JSON])
                let matches = jsonList.map({ Match(json: $0) }) 
                onSuccess(matches)
            case .failure(let error):
                onFailure(error)
            }
        })
    }
}
