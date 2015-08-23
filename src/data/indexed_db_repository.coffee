# XXX ネストしたkeyPathには対応していない
class IndexedDBRepository
    # IndexedDBをオープン
    openDatabase: ->
        new Promise (resolve, reject) =>
            request = indexedDB.open @scheme.database, @scheme.version
            request.onerror = (err) -> reject err

            upgradeCompleted = true
            succeeded = false

            database = null

            request.onupgradeneeded = (event) =>
                upgradeCompleted = false

                db = event.target.result
                db.onerror = (err) -> reject err

                # ObjectStore作成
                @scheme.stores.forEach (store) ->
                    db.createObjectStore store.name,
                        keyPath: store.keyPath
                        autoIncrement: store.autoIncrement

                @onDatabaseUpgraded(db).then ->
                    upgradeCompleted = true
                    resolve database if succeeded


            request.onsuccess = (event) =>
                succeeded = true
                database = event.target.result
                resolve database if upgradeCompleted


    onDatabaseUpgraded: ->
        Promise.resolve()


    openObjectStore: (storeName, mode) ->
        new Promise (resolve, reject) =>
            @openDatabase().then (db) ->
                db.onerror = (err) -> reject err

                store = db.transaction storeName, mode
                    .objectStore storeName

                resolve store


    openReadonlyStore: (storeName) ->
        new Promise (resolve, reject) =>
            @openObjectStore(storeName, "readonly").then (store) ->
                resolve store


    openWritableStore: (storeName) ->
        new Promise (resolve, reject) =>
            @openObjectStore(storeName, "readwrite").then (store) ->
                resolve store


    deleteDatabase: ->
        new Promise (resolve, reject) =>
            request = indexedDB.deleteDatabase @scheme.database
            request.onsuccess = -> resolve
            request.onerror = -> reject()


    getList: (storeName) ->
        new Promise (resolve, reject) =>
            @openReadonlyStore(storeName).then (objectStore) ->
                list = []

                objectStore.openCursor().onsuccess = (event) ->
                    cursor = event.target.result
                    if cursor
                        list.push cursor.value
                        cursor.continue()
                    else
                        resolve list


    delete: (storeName, key) ->
        new Promise (resolve, reject) =>
            @openWritableStore(storeName).then (objectStore) ->
                request = objectStore.delete key
                request.onerror = (err) ->
                    reject err

                request.onsuccess = ->
                    resolve()


    saveToStore: (storeName, obj) ->
        new Promise (resolve, reject) =>
            keyPath = @_getKeyPath storeName

            @openWritableStore(storeName).then (store) =>
                if obj[keyPath] == undefined
                    delete obj[keyPath]
                    request = store.add obj
                else
                    request = store.put obj

                request.onsuccess = (event) ->
                    resolve event.target.result

                request.onerror = (err) ->
                    reject err


    _getKeyPath: (storeName) ->
        keyPath

        for store in @scheme.stores
            keyPath = store.keyPath if (storeName == store.name)

        keyPath


module.exports = IndexedDBRepository

