package org.openehr.antlr;

import java.util.HashMap;
import java.util.List;
import java.util.stream.Collectors;

public class MultiSyntaxErrorCollector implements IANTLRParserErrors {

    // ------------------ Creation ------------------

    public MultiSyntaxErrorCollector() {
        errorTable = new HashMap<>();
    }

    // ------------------ Access ------------------

    public boolean hasNoErrors() {
        return errorTable.values().stream().allMatch (IANTLRParserErrors::hasNoErrors);
    }

    public boolean hasErrors() {
        return errorTable.values().stream().anyMatch (IANTLRParserErrors::hasErrors);
    }

    public boolean hasWarnings() {
        return errorTable.values().stream().anyMatch (IANTLRParserErrors::hasWarnings);
    }

    public List<ANTLRParserMessage> getWarnings() {
        return errorTable.values()
                .stream()
                .flatMap(x -> x.getWarnings().stream())
                .collect(Collectors.toList());
    }

    @Override
    public boolean hasNoMessages() {
        return errorTable.values().stream().allMatch (IANTLRParserErrors::hasNoMessages);
    }

    public List<ANTLRParserMessage> getErrors() {
        return errorTable.values()
                .stream()
                .flatMap(x -> x.getErrors().stream())
                .collect(Collectors.toList());
    }

    // ------------------ Implementation ------------------

    protected final HashMap<String, IANTLRParserErrors> errorTable;
}
