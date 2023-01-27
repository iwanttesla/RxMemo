//
//  MemoryStorage.swift
//  RxMemo
//
//  Created by OCUBE on 2023/01/27.
//

import Foundation
import RxSwift

class MemoryStorage:MemoStorageType{

    private var list = [
        Memo(content: "Hello, RxSwift",insertData: Date().addingTimeInterval(-10)),
        Memo(content: "Lorem Inpsum",insertData: Date().addingTimeInterval(-20))
    ]
    
    //기본값을 list배열로 선언하기위해 lazy로 선언, 외부에서 직접 접근할 필요없어 private으로 선언.
    private lazy var store = BehaviorSubject<[Memo]>(value: list)

    @discardableResult
    func createMemo(content: String) -> Observable<Memo> {
        let memo = Memo(content: content)
        list.insert(memo, at: 0)
        
        //서브젝트에서 넥스트 이벤트를 방출
        store.onNext(list)
        
        //새로운 메모를 방출하는 옵저버블을 리턴
        return Observable.just(memo)
    }
    
    @discardableResult
    func memoList() -> Observable<[Memo]> {
        return store
    }
    
    @discardableResult
    func update(memo: Memo, content: String) -> Observable<Memo> {
        let updated = Memo(original: memo, updatedContent: content)
        
        //배열에 저장된 기본인스턴스를 새로운 인스턴스로 교체
        if let index = list.firstIndex(where: { $0 == memo }){
            list.remove(at: index)
            list.insert(updated, at: index)
        }
        
        //새로운 리스트를 넥스트이벤트로 방출
        store.onNext(list)
        
        //업데이트된 리스트를 방출하는 옵저버블을 리턴
        return Observable.just(updated)
    }
    
    @discardableResult
    func delete(memo: Memo) -> Observable<Memo> {
        if let index = list.firstIndex(where: { $0 == memo }){
            list.remove(at: index)
        }
        
        store.onNext(list)
        
        //삭제된 리스트를 방출하는 옵저버블 리턴
        return Observable.just(memo)
    }
    
    
}
