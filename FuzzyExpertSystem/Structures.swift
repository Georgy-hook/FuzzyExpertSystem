//
//  Structures.swift
//  ExpertSystem
//
//  Created by Georgy on 17.10.2022.
//
import RealmSwift
class Variative1: Object {
    @Persisted var Xvalue:Int
    @Persisted var Ans1:String
    @Persisted var Yvalue1:Double
    @Persisted var Ans2:String
    @Persisted var Yvalue2:Double
    @Persisted var Ans3:String
    @Persisted var Yvalue3:Double
}
class Variative2: Object {
    @Persisted var Xvalue:Double
    @Persisted var Ans1:String
    @Persisted var Yvalue1:Double
    @Persisted var Ans2:String
    @Persisted var Yvalue2:Double
    @Persisted var Ans3:String
    @Persisted var Yvalue3:Double
}
class Variative3: Object {
    @Persisted var Xvalue:Int
    @Persisted var Ans1:String
    @Persisted var Yvalue1:Double
    @Persisted var Ans2:String
    @Persisted var Yvalue2:Double
    @Persisted var Ans3:String
    @Persisted var Yvalue3:Double
}

class VaritivesChanges: Object {
    @Persisted var Var1:Variative1?
    @Persisted var Var2:Variative2?
    @Persisted var Var3:Variative3?
}
class VariativeActiv: Object {
    @Persisted var Xvalue:Int
    @Persisted var Ans1:String
    @Persisted var Yvalue1:Double
    @Persisted var Ans2:String
    @Persisted var Yvalue2:Double
    @Persisted var Ans3:String
    @Persisted var Yvalue3:Double
}
