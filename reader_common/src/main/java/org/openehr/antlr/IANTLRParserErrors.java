package org.openehr.antlr;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by pieter.bos on 19/10/15.
 */
public interface IANTLRParserErrors {

    public List<ANTLRParserMessage> getErrors() ;

    public List<ANTLRParserMessage> getWarnings();

    public boolean hasNoMessages() ;

    public boolean hasNoErrors() ;

    public boolean hasErrors() ;

    public boolean hasWarnings() ;

}
