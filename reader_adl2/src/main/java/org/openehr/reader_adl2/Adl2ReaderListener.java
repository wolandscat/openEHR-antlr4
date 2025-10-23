// Generated from AdlParser.g4 by ANTLR 4.9.2
package org.openehr.reader_adl2;

import org.antlr.v4.runtime.ParserRuleContext;
import org.antlr.v4.runtime.tree.ErrorNode;
import org.antlr.v4.runtime.tree.TerminalNode;
import org.openehr.parser_adl2.Adl2Parser;
import org.openehr.parser_adl2.Adl2ParserListener;
import org.openehr.belReader.BelReader;
import org.openehr.cadlReader.Cadl2Reader;
import org.openehr.common.SyntaxUtils;
import org.openehr.odinReader.OdinReader;

/**
 * This class provides an empty implementation of {@link Adl2ReaderListener},
 * which can be extended to create a listener which only needs to handle a subset
 * of the available methods.
 */
public class Adl2ReaderListener implements Adl2ParserListener {

	public Adl2ReaderListener(boolean logging, boolean keepAntlrErrors, Adl2ReaderErrorCollector errorCollector, int lineOffset) {
		odinReader = new OdinReader (logging, keepAntlrErrors);
		cadl2Reader = new Cadl2Reader(logging, keepAntlrErrors);
		expressionReader = new BelReader(logging, keepAntlrErrors);
		this.errorCollector = errorCollector;
		this.lineOffset = lineOffset;
	}

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	@Override public void enterAdlObject(Adl2Parser.AdlObjectContext ctx) { }

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	@Override public void exitAdlObject(Adl2Parser.AdlObjectContext ctx) { }

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	@Override public void enterAuthoredArchetype(Adl2Parser.AuthoredArchetypeContext ctx) { }

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	@Override public void exitAuthoredArchetype(Adl2Parser.AuthoredArchetypeContext ctx) { }

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	@Override public void enterTemplate(Adl2Parser.TemplateContext ctx) { }

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	@Override public void exitTemplate(Adl2Parser.TemplateContext ctx) { }

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	@Override public void enterTemplateOverlay(Adl2Parser.TemplateOverlayContext ctx) { }

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	@Override public void exitTemplateOverlay(Adl2Parser.TemplateOverlayContext ctx) { }

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	@Override public void enterOperationalTemplate(Adl2Parser.OperationalTemplateContext ctx) { }

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	@Override public void exitOperationalTemplate(Adl2Parser.OperationalTemplateContext ctx) { }

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	@Override public void enterHeader(Adl2Parser.HeaderContext ctx) { }

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	@Override public void exitHeader(Adl2Parser.HeaderContext ctx) { }

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	@Override public void enterMetaData(Adl2Parser.MetaDataContext ctx) { }

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	@Override public void exitMetaData(Adl2Parser.MetaDataContext ctx) { }

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	@Override public void enterMetaDataItem(Adl2Parser.MetaDataItemContext ctx) { }

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	@Override public void exitMetaDataItem(Adl2Parser.MetaDataItemContext ctx) { }

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	@Override public void enterMetaDataValueItem(Adl2Parser.MetaDataValueItemContext ctx) { }

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	@Override public void exitMetaDataValueItem(Adl2Parser.MetaDataValueItemContext ctx) { }

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	@Override public void enterMetaDataFlag(Adl2Parser.MetaDataFlagContext ctx) { }

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	@Override public void exitMetaDataFlag(Adl2Parser.MetaDataFlagContext ctx) { }

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	@Override public void enterMetaDataItemValue(Adl2Parser.MetaDataItemValueContext ctx) { }

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	@Override public void exitMetaDataItemValue(Adl2Parser.MetaDataItemValueContext ctx) { }

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	@Override public void enterSpecializeSection (Adl2Parser.SpecializeSectionContext ctx) { }

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	@Override public void exitSpecializeSection (Adl2Parser.SpecializeSectionContext ctx) { }

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	@Override public void enterLanguageSection (Adl2Parser.LanguageSectionContext ctx) {
		odinReader.read (SyntaxUtils.textToCharStream (ctx.odinText().ODIN_LINE()), Adl2ReaderDefinitions.LANGUAGE_SECTION_NAME, ctx.LANGUAGE_HEADER().getSymbol().getLine());
		errorCollector.setLanguageErrors (odinReader.getErrors());
	}

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	@Override public void exitLanguageSection (Adl2Parser.LanguageSectionContext ctx) { }

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	@Override public void enterDescriptionSection (Adl2Parser.DescriptionSectionContext ctx) {
		odinReader.read(SyntaxUtils.textToCharStream (ctx.odinText().ODIN_LINE()), Adl2ReaderDefinitions.DESCRIPTION_SECTION_NAME, ctx.DESCRIPTION_HEADER().getSymbol().getLine());
		errorCollector.setDescriptionErrors (odinReader.getErrors());
	}

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	@Override public void exitDescriptionSection (Adl2Parser.DescriptionSectionContext ctx) { }

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	@Override public void enterDefinitionSection (Adl2Parser.DefinitionSectionContext ctx) {
		cadl2Reader.read (SyntaxUtils.textToCharStream (ctx.cadlText().CADL_LINE()), Adl2ReaderDefinitions.DEFINITION_SECTION_NAME,
				ctx.DEFINITION_HEADER().getSymbol().getLine());
		errorCollector.setDefinitionErrors (cadl2Reader.getErrors());
	}

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	@Override public void exitDefinitionSection (Adl2Parser.DefinitionSectionContext ctx) { }
	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	@Override public void enterRulesSection (Adl2Parser.RulesSectionContext ctx) {
		expressionReader.read (SyntaxUtils.textToCharStream (ctx.elText().EL_LINE()), Adl2ReaderDefinitions.RULES_SECTION_NAME, ctx.RULES_HEADER().getSymbol().getLine());
		errorCollector.setRulesErrors (expressionReader.getErrors());
	}

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	@Override public void exitRulesSection (Adl2Parser.RulesSectionContext ctx) { }

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	@Override public void enterRmOverlaySection (Adl2Parser.RmOverlaySectionContext ctx) {
		odinReader.read (SyntaxUtils.textToCharStream (ctx.odinText().ODIN_LINE()), Adl2ReaderDefinitions.RM_OVERLAY_SECTION_NAME, ctx.RM_OVERLAY_HEADER().getSymbol().getLine());
		errorCollector.setRmOverlayErrors (odinReader.getErrors());
	}

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	@Override public void exitRmOverlaySection (Adl2Parser.RmOverlaySectionContext ctx) { }

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	@Override public void enterTerminologySection (Adl2Parser.TerminologySectionContext ctx) {
		odinReader.read (SyntaxUtils.textToCharStream (ctx.odinText().ODIN_LINE()), Adl2ReaderDefinitions.TERMINOLOGY_SECTION_NAME, ctx.TERMINOLOGY_HEADER().getSymbol().getLine());
		errorCollector.setTerminologyErrors (odinReader.getErrors());
	}

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	@Override public void exitTerminologySection (Adl2Parser.TerminologySectionContext ctx) { }

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	@Override public void enterAnnotationsSection (Adl2Parser.AnnotationsSectionContext ctx) {
		odinReader.read (SyntaxUtils.textToCharStream (ctx.odinText().ODIN_LINE()), Adl2ReaderDefinitions.ANNOTATIONS_SECTION_NAME, ctx.ANNOTATIONS_HEADER().getSymbol().getLine());
		errorCollector.setAnnotationsErrors (odinReader.getErrors());
	}

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	@Override public void exitAnnotationsSection (Adl2Parser.AnnotationsSectionContext ctx) { }

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	@Override public void enterComponentTerminologiesSection (Adl2Parser.ComponentTerminologiesSectionContext ctx) {
		odinReader.read (SyntaxUtils.textToCharStream (ctx.odinText().ODIN_LINE()), Adl2ReaderDefinitions.COMPONENT_TERMINOLOGIES_SECTION_NAME, ctx.COMPONENT_TERMINOLOGIES_HEADER().getSymbol().getLine());
		errorCollector.setAnnotationsErrors (odinReader.getErrors());
	}

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	@Override public void exitComponentTerminologiesSection (Adl2Parser.ComponentTerminologiesSectionContext ctx) { }

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	@Override public void enterOdinText(Adl2Parser.OdinTextContext ctx) { }

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	@Override public void exitOdinText(Adl2Parser.OdinTextContext ctx) { }

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	@Override public void enterCadlText(Adl2Parser.CadlTextContext ctx) { }

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	@Override public void exitCadlText(Adl2Parser.CadlTextContext ctx) { }

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	@Override public void enterElText(Adl2Parser.ElTextContext ctx) { }

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	@Override public void exitElText(Adl2Parser.ElTextContext ctx) { }

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	@Override public void enterEveryRule(ParserRuleContext ctx) { }

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	@Override public void exitEveryRule(ParserRuleContext ctx) { }

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	@Override public void visitTerminal(TerminalNode node) { }

	/**
	 * {@inheritDoc}
	 *
	 * <p>The default implementation does nothing.</p>
	 */
	@Override public void visitErrorNode(ErrorNode node) { }

	// -------------- Implementation ------------------

	private final int lineOffset;

	private final OdinReader odinReader;
	private final Cadl2Reader cadl2Reader;
	private final BelReader expressionReader;

	private final Adl2ReaderErrorCollector errorCollector;

}