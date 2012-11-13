module Database.Memcache.Utils (
        statusToError,
        throwStatus,
        throwIncorrectRes
    ) where

import Database.Memcache.Types

import Control.Exception

statusToError :: Status -> MemcacheError
statusToError NoError            = error "statusToError: called on NoError"
statusToError ErrKeyNotFound     = MemErrNoKey
statusToError ErrKeyExists       = MemErrKeyExists
statusToError ErrValueTooLarge   = MemErrValueTooLarge
statusToError ErrInvalidArgs     = MemErrInvalidArgs
statusToError ErrItemNotStored   = MemErrStoreFailed
statusToError ErrValueNonNumeric = MemErrValueNonNumeric
statusToError ErrUnknownCommand  = MemErrUnknownCmd
statusToError ErrOutOfMemory     = MemErrOutOfMemory
statusToError SaslAuthFail       = error "statusToError: called on SaslAuthFail"
statusToError SaslAuthContinue   = error "statusToError: called on SaslAuthContinue"

throwStatus :: Response -> IO a
throwStatus r = throwIO $ statusToError $ resStatus r

throwIncorrectRes :: Response -> String -> IO a
throwIncorrectRes r msg = throwIO $
    IncorrectResponse {
        increspMessage = "Expected " ++ msg ++ " response! Got: " ++ show (resOp r),
        increspActual  = r
    }

