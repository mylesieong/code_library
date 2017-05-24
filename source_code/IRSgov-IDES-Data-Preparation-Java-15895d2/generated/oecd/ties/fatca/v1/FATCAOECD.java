//
// This file was generated by the JavaTM Architecture for XML Binding(JAXB) Reference Implementation, vJAXB 2.1.10 in JDK 6 
// See <a href="http://java.sun.com/xml/jaxb">http://java.sun.com/xml/jaxb</a> 
// Any modifications to this file will be lost upon recompilation of the source schema. 
// Generated on: 2014.11.07 at 07:17:25 PM EST 
//


package oecd.ties.fatca.v1;

import java.util.ArrayList;
import java.util.List;
import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlAttribute;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlType;
import oecd.ties.stffatcatypes.v1.MessageSpecType;


/**
 * <p>Java class for anonymous complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType>
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="MessageSpec" type="{urn:oecd:ties:stffatcatypes:v1}MessageSpec_Type"/>
 *         &lt;element name="FATCA" type="{urn:oecd:ties:fatca:v1}Fatca_Type" maxOccurs="unbounded"/>
 *       &lt;/sequence>
 *       &lt;attribute name="version" type="{http://www.w3.org/2001/XMLSchema}string" />
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "", propOrder = {
    "messageSpec",
    "fatca"
})
@XmlRootElement(name = "FATCA_OECD")
public class FATCAOECD {

    @XmlElement(name = "MessageSpec", required = true)
    protected MessageSpecType messageSpec;
    @XmlElement(name = "FATCA", required = true)
    protected List<FatcaType> fatca;
    @XmlAttribute
    protected String version;

    /**
     * Gets the value of the messageSpec property.
     * 
     * @return
     *     possible object is
     *     {@link MessageSpecType }
     *     
     */
    public MessageSpecType getMessageSpec() {
        return messageSpec;
    }

    /**
     * Sets the value of the messageSpec property.
     * 
     * @param value
     *     allowed object is
     *     {@link MessageSpecType }
     *     
     */
    public void setMessageSpec(MessageSpecType value) {
        this.messageSpec = value;
    }

    /**
     * Gets the value of the fatca property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the JAXB object.
     * This is why there is not a <CODE>set</CODE> method for the fatca property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getFATCA().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link FatcaType }
     * 
     * 
     */
    public List<FatcaType> getFATCA() {
        if (fatca == null) {
            fatca = new ArrayList<FatcaType>();
        }
        return this.fatca;
    }

    /**
     * Gets the value of the version property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getVersion() {
        return version;
    }

    /**
     * Sets the value of the version property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setVersion(String value) {
        this.version = value;
    }

}
